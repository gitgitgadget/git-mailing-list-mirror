From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH/RFC 08/11] daemon: use explicit file descriptor
Date: Fri, 27 Nov 2009 15:23:02 +0100
Message-ID: <40aa078e0911270623m1a06890cmd2d46b3d9e216769@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-8-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-9-git-send-email-kusmabite@gmail.com>
	 <200911262303.57228.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Nov 27 15:23:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE1j7-0008Ol-5Z
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 15:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbZK0OXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 09:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754227AbZK0OW7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 09:22:59 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:49771 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbZK0OW5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 09:22:57 -0500
Received: by ewy19 with SMTP id 19so1461341ewy.21
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 06:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0b7XO5Brr2DuI4J2ujyzshyYh8NHVE++Ytn9vpSyupI=;
        b=aVebRVRFF8exy7FJPuNTg+WXg12kakNGaWWhW/ojUSPY5AX38SY/Lemuwl6xFjI670
         HpHJiQ0Mw7XRIwHRJmXMJgo/kLkjVOjGJxvSbbeedzSJ92A7qKW0phoGpOMBSuyQOUAA
         xGtkCViggPoAdRP/qiBIRdBoxtc72VA0Rrn8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=UQUAFWSRQplg9uSN6gLtWLdJC/lLLb4ZQdJhF/XMb5B7S7UfJ9zM0JqnOErMDj0uKp
         aYiUz/fqRdIIVcrc/UWtKhkxKYqsGFOejNpN6OBxxicvJG0IoOcunGCm4H0VKcLe1tn/
         rEyd4Pz2vGBXm52FGsuNdd34l7U3RbFL32elI=
Received: by 10.216.90.209 with SMTP id e59mr350986wef.193.1259331782646; Fri, 
	27 Nov 2009 06:23:02 -0800 (PST)
In-Reply-To: <200911262303.57228.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133895>

Sorry for the long delay in the reply, but I'm a little low on time
these days (and I've already spent some time trying to figure out what
I was thinking - I wrote these patches a while ago).

On Thu, Nov 26, 2009 at 11:03 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
>> @@ -372,37 +372,35 @@ static int run_service_command(const char **ar=
gv)
>> =A0 =A0 =A0 cld.argv =3D argv;
>> =A0 =A0 =A0 cld.git_cmd =3D 1;
>> =A0 =A0 =A0 cld.err =3D -1;
>> + =A0 =A0 cld.in =3D cld.out =3D fd;
>
> You shouldn't do that. In fact, the next patch 9 has a hunk that corr=
ectly
> calls dup() once.
>

OK, as long as it works as expected, sure. But perhaps this needs a
little change (see discussion later)

>> - =A0 =A0 close(0);
>> - =A0 =A0 close(1);
>
> Here, stdin and stdout were closed and start_command() used both. But=
 these
> two new calls
>
>> + =A0 =A0 exit(execute(0, addr));
>> ...
>> + =A0 =A0 =A0 =A0 =A0 =A0 return execute(0, peer);
>
> are the only places where a value is assigned to fd. Now it is always=
 only
> stdin. Where does the old code initialize stdout? Shouldn't this plac=
e need a
> change, too?

The "dup2(incoming, 0)"-call in handle() is AFAICT what makes it work
to use the forked process' stdin as both stdin and stdout for the
service-process pipe (since fd 0 now becomes a pipe that is both
readable and writable). This isn't exactly a pretty mechanism, and I
guess I should rework it. At the very least, I should remove the
"dup2(incoming, 1)"-call, but I'm open to other suggestions. Perhaps I
can change this patch to do the entire socket-passing (which is
currently in the next patch)?

--=20
Erik "kusma" Faye-Lund
