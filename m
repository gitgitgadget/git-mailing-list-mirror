From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] git diff ignore-space options should ignore missing EOL 
	at EOF differences
Date: Sun, 15 Feb 2009 16:13:50 +0100
Message-ID: <9b18b3110902150713q62a73febs3d76ebf6e0d93c46@mail.gmail.com>
References: <9b18b3110902150609q13333619k98f87a4a36a09030@mail.gmail.com>
	 <alpine.DEB.1.00.0902151554000.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, davidel@xmailserver.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 16:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYiiT-0003q7-A1
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 16:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbZBOPNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 10:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbZBOPNw
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 10:13:52 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:60542 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZBOPNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 10:13:52 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1109405qwi.37
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 07:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Mu5z6SX6lKI9Ontycs1IdjdTJwPHq6A/pibg0Yhk+y0=;
        b=NOGTqb9Yo2ijUQG/xudFpQTDWFqemDRP4KfTSxP45N+xrg8/RSjyK1GmioeoEwh9I1
         VzxAJFw6UG7bho9DqK0Ku1BnWT35Xwr9vNI7FJUCC/W9PnHXuOfvKQE69m15QboHw0RF
         SMNtwQWsUR8+h0YxFmVdfuYkBsyiVG/53US8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nEhSGDtaTMUiILFObChXiVq11nTlfOBS+GgCkGkZ5r0Dv1h0H+rCAb1mq9i5zw63pw
         IjrwAU2e3TC1mcxfae2aPYfs2QEXD619neYOs4F5thy4pFRat1gZrChnuEHRXkXyskgh
         EFG2Q8qkyiVnUxOVKv7YbU2rYc7RKMbHR7mVw=
Received: by 10.224.67.75 with SMTP id q11mr6409695qai.274.1234710830913; Sun, 
	15 Feb 2009 07:13:50 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902151554000.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110015>

2009/2/15 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Sun, 15 Feb 2009, demerphq wrote:
>
>>  t/t4015-diff-whitespace.sh             |   79 ++++++++++++++++++++++++++++++++
>
> Phew, you certainly want to make sure that it works...

Yeah, Exhaustive testing is good. (When it doesn't take hours and
hours to run :-)

>
>> @@ -33,7 +33,14 @@ extern "C" {
>>  #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
>>  #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
>>  #define XDF_PATIENCE_DIFF (1 << 5)
>> -#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE |
>> XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
>> +#define XDF_IGNORE_WHITESPACE_AT_EOF (1 << 6)
>> +/*
>> + * note this is deliberately a different define from XDF_WHITESPACE_FLAGS as
>> + * there could be a new whitespace related flag which would not be part of
>> + * the XDF_IGNORE_WHITESPACE_AT_EOF_ANY flags.
>> + */
>> +#define XDF_IGNORE_WHITESPACE_AT_EOF_ANY
>> (XDF_IGNORE_WHITESPACE_AT_EOL | XDF_IGNORE_WHITESPACE_CHANGE |
>> XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_AT_EOF)
>> +#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE |
>> XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL |
>> XDF_IGNORE_WHITESPACE_AT_EOF)
>
> As I told you on IRC, I do not follow that reasoning.  Rather, I would add
> the exceptions to xemit.c, when -- and if(!) -- they are needed.

Yeah I know you said that, and I *think* I followed all your advice
(much appreciated by the way) except for that point as I've been
nailed by inappropriate addition of flags to masks before, and well,
you know, once bitten twice shy, and patchers perogative and all that
eh? :-)

For instance what happens if someone adds XDF_IGNORE_WHITESPACE_AT_SOL
(start of line) or XDF_IGNORE_SPACES_WHERE_TABS_EXPECTED in the
future, and then adds it to XDF_IGNORE_WHITESPACE_FLAGS? And
personally such options seem quite reasonable to me. It just happens
to be coincidence that all of the currently existing flags also impact
this particular behaviour, IMO it wouldnt have been so strange to find
one that didn't.

And thanks again for your handholding on this patch. I hope the
pasting of it inline was correct. I'm not sure where I should have
said that it was a patch against the master branch without it also
appearing in the commit body. Should I haved attached the format-patch
file as well?

Also, on a related note I personally would have reorganized the flags
so that the ones relating to whitespace control are in a different bit
range than the ones that have to do with other things. The precedent
in the file appeared to not follow this approach as the patience flag
was "at the end", so i didnt modify this, and just stuck the new flag
also at the end. I think it would be better to do a lowbit moving up
and highbit moving down approach or something like that as otherwise
when new flags get added over time the different types of flags are
interspersed and it becomes a real mess to maintain and understand. In
fact, I dont really "get" the whitespace flags as currently
implemented. Why does "ignore all whitespace" get its own bit?
Shouldn't it just be a mask of all the other whitespace bits?

cheers,
Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
