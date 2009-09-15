From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/2] Work around leftover temporary save file.
Date: 15 Sep 2009 15:47:12 +0100
Message-ID: <87tyz4b6z3.fsf@users.sourceforge.net>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
	<87ab0wcsyp.fsf@users.sourceforge.net>
	<81b0412b0909150601j74d40181pc2308f4f63b4817e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexy Borzenkov <snaury@gmail.com>,
	Paul Mackerras <paulus@samba.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 16:47:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnZJX-0002La-7C
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 16:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbZIOOrO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 10:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754439AbZIOOrO
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 10:47:14 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:40854 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754370AbZIOOrN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 10:47:13 -0400
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MnZJL-0006ZK-OI; Tue, 15 Sep 2009 15:47:15 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MnZJJ-0003Oy-HP; Tue, 15 Sep 2009 15:47:13 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id ECC5B51843; Tue, 15 Sep 2009 15:47:12 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <81b0412b0909150601j74d40181pc2308f4f63b4817e@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128568>

Alex Riesen <raa.lkml@gmail.com> writes:

>On Tue, Sep 15, 2009 at 11:26, Pat Thoyts
><patthoyts@users.sourceforge.net> wrote:
>>
>> If a file exists and is hidden on Windows the Tcl open command will
>> fail as the attributes provided in the CREAT call fail to match thos=
e
>> of the existing file. Forcing removal of the temporary file before w=
e
>> begin solves any problems caused by previous failures to save the
>> application settings. An alternative would be to remove the hidden
>> attribute before calling 'open'.
>>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> ---
>> =A0gitk | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/gitk b/gitk
>> index 1306178..a0214b7 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -2526,6 +2526,7 @@ proc savestuff {w} {
>> =A0 =A0 if {$stuffsaved} return
>> =A0 =A0 if {![winfo viewable .]} return
>> =A0 =A0 catch {
>> + =A0 =A0 =A0 if {[file exists ~/.gitk-new]} {file delete -force ~/.=
gitk-new}
>
>maybe another gitk instance is writing it at exactly same moment
>in time? Writing is known to take a few moments. Especially on Windows=
=2E

no - 'open $file w' is translated into O_WRONLY|O_CREAT|O_TRUNC
internally and passed to the win32 layer to get converted to a call to =
CreateFile with
GENERIC_WRITE, CREATE_ALWAYS and FILE_ATTRIBUTE_NORMAL. The file has
got FILE_ATTRIBUTE_HIDDEN though and as it exists and our attributes
do not match we get failed.
'open $file {O_WRONLY O_TRUNC}' would open it but we'd have to check
for non-existence and redo with O_CREAT if it was not already present.

See tclWinChan.c:TclpOpenFileChannel.

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
