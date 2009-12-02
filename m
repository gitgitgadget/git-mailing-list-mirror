From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH/RFC 09/11] daemon: use run-command api for async 
	serving
Date: Wed, 2 Dec 2009 16:45:03 +0100
Message-ID: <40aa078e0912020745o4b72342fm722a944621cfda5@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-9-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-10-git-send-email-kusmabite@gmail.com>
	 <200911272159.38757.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 16:45:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFrOH-0007I8-GG
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 16:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbZLBPo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2009 10:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754559AbZLBPo7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 10:44:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:31796 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455AbZLBPo6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 10:44:58 -0500
Received: by fg-out-1718.google.com with SMTP id e21so318601fga.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 07:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=T6SL/W/CyZIoa3fKFmgTdIZMZrj3Tm3fB91SQK8E9rk=;
        b=MwXlPlnZE6B8EOXrjOU3IAySbZgUTB32/Br6Rmv/TVjS1Cue2z8ZAzGeSW68UwIKIw
         2d0ye9uc/9vhLkR9iK0lqPMvr7Q43gSfYLU4/e0CcmziHBroHCqDrRtEsov3o9VRsurm
         KK9DHABZ773TQG/t2hU3FtDlmm2EtLFCbnZLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=VoJFPNg6ha1fppUHDRkzl0J5xz9qRG64egsvw72VSstvsnJff7Awv9WML9C/5THxEI
         ScBCHs+rPwJgMYjDx4gQ3REatrP9uKPGMtKv6APY2JzXQYXtT0JstFWUgyl55bxbMtyA
         Fr0ZSbHeihDzRVctMtG8iq++UAoJ30IDnH9GM=
Received: by 10.216.85.197 with SMTP id u47mr85944wee.133.1259768703477; Wed, 
	02 Dec 2009 07:45:03 -0800 (PST)
In-Reply-To: <200911272159.38757.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134339>

On Fri, Nov 27, 2009 at 9:59 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
>> =A0static void check_dead_children(void)
>> =A0{
>> - =A0 =A0 int status;
>> - =A0 =A0 pid_t pid;
>> -
>> - =A0 =A0 while ((pid =3D waitpid(-1, &status, WNOHANG)) > 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 const char *dead =3D "";
>> - =A0 =A0 =A0 =A0 =A0 =A0 remove_child(pid);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!WIFEXITED(status) || (WEXITSTATUS(sta=
tus) > 0))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dead =3D " (with error)";
>> - =A0 =A0 =A0 =A0 =A0 =A0 loginfo("[%"PRIuMAX"] Disconnected%s", (ui=
ntmax_t)pid, dead);
>> - =A0 =A0 }
>> + =A0 =A0 struct child **cradle, *blanket;
>> + =A0 =A0 for (cradle =3D &firstborn; (blanket =3D *cradle);)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!is_async_alive(&blanket->async)) {
>
> This would be the right place to call finish_async(). But since we ca=
nnot
> wait, you invented is_async_alive(). But actually we are not only int=
erested
> in whether the process is alive, but also whether it completed succes=
sfully
> so that we can add "(with error)". Would it make sense to have a func=
tion
> finish_async_nowait() instead of is_async_alive() that (1) stresses t=
he
> start/finish symmetry and (2) can return more than just Boolean?
>

Yes, it does.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cradle =3D blanket->next;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 loginfo("Disconnected\n");
>
> Here you are losing information about the pid, which is important to =
have in
> the syslog. The \n should be dropped.
>

Yeah... I removed the pid mostly because after moving to async, there
wasn't "just a pid" any more. But if we make finish_async_nowait()
return whatever we need to report, I guess we can add the information
back somehow.

I'm not entirely sure how to make the interface, though. Any good sugge=
stions?

>> + =A0 =A0 async.proc =3D async_execute;
>> + =A0 =A0 async.data =3D ss;
>> + =A0 =A0 async.out =3D incoming;
>>
>> - =A0 =A0 dup2(incoming, 0);
>> - =A0 =A0 dup2(incoming, 1);
>> + =A0 =A0 if (start_async(&async))
>> + =A0 =A0 =A0 =A0 =A0 =A0 logerror("unable to fork");
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 add_child(&async, addr, addrlen);
>> =A0 =A0 =A0 close(incoming);
>> -
>> - =A0 =A0 exit(execute(0, addr));
>
> In start_command(), the convention is that fds that are provided by t=
he caller
> are closed by start_command() (even if there are errors). The close(i=
ncoming)
> that you leave here indicates that you are not using the same convent=
ion with
> start_async(). It would be nice to switch to the same convention.
>

Yeah, I've fixed this for the next round.

--=20
Erik "kusma" Faye-Lund
