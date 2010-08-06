From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-gui: Use shell to launch textconv filter in "blame"
Date: Fri, 06 Aug 2010 10:51:23 +0200
Message-ID: <vpqaap0cees.fsf@bauges.imag.fr>
References: <vpqlj8l2xd5.fsf@bauges.imag.fr>
	<1281002722-3042-1-git-send-email-Matthieu.Moy@imag.fr>
	<87aap0sljs.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Aug 06 10:53:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhIfk-0000vW-3E
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 10:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760786Ab0HFIwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 04:52:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57272 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760732Ab0HFIwe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 04:52:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o768nBjX018147
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Aug 2010 10:49:11 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OhIeC-00047V-9U; Fri, 06 Aug 2010 10:51:24 +0200
In-Reply-To: <87aap0sljs.fsf@fox.patthoyts.tk> (Pat Thoyts's message of "Fri\, 06 Aug 2010 00\:10\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Aug 2010 10:49:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o768nBjX018147
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281689352.99063@pCp9S4gwzeiI9o8fiClE7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152772>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

>> 	if {$commit eq {}} {
>> 		if {$do_textconv ne 0} {
>>-			set fd [open |[list $textconv $path] r]
>>+			# Run textconv with sh -c "..." to allow it to
>>+			# contain command + arguments.
>>+			set fd [open |[list [shellpath] -c "$textconv \"\$0\"" $path] r]
>> 		} else {
>> 			set fd [open $path r]
>> 		}
>
> I don't believe we need to put all this in to launch this via the
> shell. We just have to pass a list where the first element is the
> command-name.
>
> The following works for me using your 'textconv = odf2txt --width=40'
> test and also a 'textconv = od -t x1' that I tried for a hex dump
> output. I couldn't make run-mailcap do anything useful for me.
>
> diff --git a/lib/blame.tcl b/lib/blame.tcl
> index 2137ec9..c06ef04 100644
> --- a/lib/blame.tcl
> +++ b/lib/blame.tcl
> @@ -460,7 +460,7 @@ method _load {jump} {
>         }
>         if {$commit eq {}} {
>                 if {$do_textconv ne 0} {
> -                       set fd [open |[list $textconv $path] r]
> +                       set fd [open |[linsert $textconv end $path] r]
>                 } else {
>                         set fd [open $path r]
>                 }

I'm not very fluent in Tcl, but I don't think this runs the command
through a shell (pstree agrees with me). That will work in most cases,
so that may be acceptable, but if you want to have full compatibility
with what "git blame" does (by using a shell) and allow e.g.

textconv = LANG=C some-command

or

textconv = cd ../; do-whatever

which are already managed by "git blame" and are OK with my version,
it's not going to do it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
