From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 3 Mar 2009 15:39:07 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F077AC@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <dpotapov@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 21:40:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LebQ7-0001Hh-Vy
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 21:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbZCCUj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 15:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbZCCUj1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 15:39:27 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:33207 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbZCCUj0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 15:39:26 -0500
X-ASG-Debug-ID: 1236112761-5cdc026e0000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 317131E3B20; Tue,  3 Mar 2009 15:39:21 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id 2GDHcuUiBlza4UlZ; Tue, 03 Mar 2009 15:39:21 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Mar 2009 15:39:20 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Thread-Index: AcmcQBlR1koy575ZR2aCJCJp8bBi9Q==
X-OriginalArrivalTime: 03 Mar 2009 20:39:20.0771 (UTC) FILETIME=[21533130:01C99C40]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236112762
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112165>

Re: AFAIK, Microsoft C runtime library does not support UTF-8,

Actually, here is a clip from the runtime library source code:

        tmode = _textmode(fh);

        switch(tmode) {
            case __IOINFO_TM_UTF8 :
                /* For a UTF-8 file, we need 2 buffers, because after
reading we
                   need to convert it into UNICODE - MultiByteToWideChar
doesn't do
                   in-place conversions. */

                /* MultiByte To WideChar conversion may double the size
of the
                   buffer required & hence we divide cnt by 2 */

                /*
                 * Since we are reading UTF8 stream, cnt bytes read may
vary
                 * from cnt wchar_t characters to cnt/4 wchar_t
characters. For
                 * this reason if we need to read cnt characters, we
will
                 * allocate MBCS buffer of cnt. In case cnt is 0, we
will
                 * have 4 as minimum value. This will make sure we don't
                 * overflow for reading from pipe case.
                 *
                 *
                 * In this case the numbers of wchar_t characters that
we can
                 * read is cnt/2. This means that the buffer size that
we will
                 * require is cnt/2.
                 */

                /* For UTF8 we want the count to be an even number */

This is in the _read(fd, buffer, count) function, and shows that it will
in fact read UTF-8 and automatically transform it to UTF-16LE
transparently.  The documentation for _open explains this feature.

Meanwhile, a quick look at _mbslen() etc. shows that they are
implemented, and will handle UTF-8 encoded text as variable-length char*
just fine as long as suitable tables are loaded in its locale.  An
internal header shows macros for generating the lead-byte information as
needed by that table.

Now, the default when a program starts is to use the "C" locale.  The
locale argument to setlocale can take a form ".code_page", so calling

	setlocale (LC_CTYPE, ".65001");

should do the trick.  Assuming, that is, that you don't hit macros that
assume that characters are never multibyte.  So define the preprocessor
symbol _MBCS when you compile.

Older versions might not work right because MBCS (multibyte character
strings) was only actually implemented to DBCS (double-byte).  That is,
a single lead byte would be followed by a second byte, and no other
cases are provided for.  But, GB18030 has up to 4 bytes in a single
character.  It might still not be completely "clean" though because
GB18030 has a "double double" nature to it.  Just like assuming 16-bit
characters period mostly works with surrogate pairs even if you didn't
code full UTF-16 support, DBCS code will see a 4-byte GB18030 character
as two double byte characters.  So it gets the len (in characters)
wrong, and might still break up what is supposed to be a single
character.  So it really needs some improvement from the historical
DBCS-only code to work properly.  

Anyway, if UTF-8 really doesn't work with MBCS functions acceptably
well, and the goal is to allow passage of all characters through the
program, then set the program to use Chinese.  GB18030 is =fully=
supported and is just another (albeit strange) encoding for Unicode.

As for what
	fprintf (stderr, "unable to open %s", path);
will do, it will have no problem copying the contents of path to the
output stream no matter how it is encoded.  The result will be sent to
stderr, which may be autotranslating the local code page to UTF-16 or
UTF-8, but by default just feeds the stream of bytes to the console
window's 8-bit API, which has its own code page setting.

Personally, I have printf'ed UTF-8 encoded text to standard output.  It
looks OK if the console is also set to UTF-8.

--John
(please excuse the footer; it's not my idea)



TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
