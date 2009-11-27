From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH/RFC 08/11] daemon: use explicit file descriptor
Date: Fri, 27 Nov 2009 16:46:49 +0100
Message-ID: <40aa078e0911270746x55946f52qd76dc4f9443aebc6@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-8-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-9-git-send-email-kusmabite@gmail.com>
	 <200911262303.57228.j6t@kdbg.org>
	 <40aa078e0911270623m1a06890cmd2d46b3d9e216769@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Nov 27 16:46:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE328-0002hY-If
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 16:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbZK0Pqp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 10:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbZK0Pqp
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 10:46:45 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:64279 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbZK0Pqo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 10:46:44 -0500
Received: by ewy19 with SMTP id 19so1542576ewy.21
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 07:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P+m0KGTG6yacmgSc4gJYIbunG/e7ueb3kmpT0Ttr1Is=;
        b=hLL35GG+cG8RR5IhMvK+xWoUnn/E6oHCV5uJ7Fled5I5mhPKuMNLrsq0/x5Atj8O2R
         mW9JKkvUOUY+gkHMT3sFWSKebxO4bD8SQo1C4q/3uh1bVjc2eok6K19UF8YGanKc9BaS
         +QQxkU7+/Mdw19WZtDQ28q1I7UtGE85+1HInY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=vjrbMa7pop4s76wMJdXtFo9bl5TcaHrwRBHRkwYYbmh/RHlEsjCmewNd5WDYF4EQhe
         BEehEFwUFf6nLIrPS2XHzGTkWfvJiI3QuQEhi9kRm1Te5zQ3mBZEYblsOwUaUUm1oQvZ
         VjosP/5zobks3l+fhBVg/h0Ky26TrPON7E9ys=
Received: by 10.216.85.197 with SMTP id u47mr369943wee.133.1259336809806; Fri, 
	27 Nov 2009 07:46:49 -0800 (PST)
In-Reply-To: <40aa078e0911270623m1a06890cmd2d46b3d9e216769@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133906>

On Fri, Nov 27, 2009 at 3:23 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> Sorry for the long delay in the reply, but I'm a little low on time
> these days (and I've already spent some time trying to figure out wha=
t
> I was thinking - I wrote these patches a while ago).
>
> On Thu, Nov 26, 2009 at 11:03 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
>>> @@ -372,37 +372,35 @@ static int run_service_command(const char **a=
rgv)
>>> =A0 =A0 =A0 cld.argv =3D argv;
>>> =A0 =A0 =A0 cld.git_cmd =3D 1;
>>> =A0 =A0 =A0 cld.err =3D -1;
>>> + =A0 =A0 cld.in =3D cld.out =3D fd;
>>
>> You shouldn't do that. In fact, the next patch 9 has a hunk that cor=
rectly
>> calls dup() once.
>>
>
> OK, as long as it works as expected, sure. But perhaps this needs a
> little change (see discussion later)
>
>>> - =A0 =A0 close(0);
>>> - =A0 =A0 close(1);
>>
>> Here, stdin and stdout were closed and start_command() used both. Bu=
t these
>> two new calls
>>
>>> + =A0 =A0 exit(execute(0, addr));
>>> ...
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return execute(0, peer);
>>
>> are the only places where a value is assigned to fd. Now it is alway=
s only
>> stdin. Where does the old code initialize stdout? Shouldn't this pla=
ce need a
>> change, too?
>
> The "dup2(incoming, 0)"-call in handle() is AFAICT what makes it work
> to use the forked process' stdin as both stdin and stdout for the
> service-process pipe (since fd 0 now becomes a pipe that is both
> readable and writable). This isn't exactly a pretty mechanism, and I
> guess I should rework it. At the very least, I should remove the
> "dup2(incoming, 1)"-call, but I'm open to other suggestions. Perhaps =
I
> can change this patch to do the entire socket-passing (which is
> currently in the next patch)?
>

Something along these lines?

---8<---
diff --git a/daemon.c b/daemon.c
index a0aead5..8774ed5 100644
--- a/daemon.c
+++ b/daemon.c
@@ -372,7 +372,8 @@ static int run_service_command(int fd, const char *=
*argv)
 	cld.argv =3D argv;
 	cld.git_cmd =3D 1;
 	cld.err =3D -1;
-	cld.in =3D cld.out =3D fd;
+	cld.in =3D dup(fd);
+	cld.out =3D fd;
 	if (start_command(&cld))
 		return -1;

@@ -707,11 +708,7 @@ static void handle(int incoming, struct sockaddr
*addr, int addrlen)
 		return;
 	}

-	dup2(incoming, 0);
-	dup2(incoming, 1);
-	close(incoming);
-
-	exit(execute(0, addr));
+	exit(execute(incoming, addr));
 }

 static void child_handler(int signo)
---8<---

When I think more about it, I might've broken the inetd-mode as it
should communicate over stdin and stdout (not just stdin as it would
try to do now)... I don't know the inetd internals, but this frightens
me a bit.

So perhaps I'll need to provide support for two unidirectional file
descriptors after all?

--=20
Erik "kusma" Faye-Lund
