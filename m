From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Segfault in "git remote show <remote-name>"
Date: Mon, 25 May 2009 18:10:12 +0200
Message-ID: <40aa078e0905250910v268faa66p29a0183db26cb0df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 25 18:10:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8ckr-0000ze-L4
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 18:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbZEYQKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 12:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbZEYQKO
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 12:10:14 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:56307 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbZEYQKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 12:10:12 -0400
Received: by bwz22 with SMTP id 22so3198067bwz.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=sEnaa/HvkwIq8oSSrWXLmVZoPuzxA7VR4uQVCpEc8MI=;
        b=if/euQMeXv7nxSAnj5E8t/BKDbKdC1vE2ypTr7gdx2fsB03/8VVcvYlA7Db3cSr1FP
         w0cjYkJjb9mpff1V/zK3H/EdEX+I4nJBz9METi6Kh+Ol11oOXm0W5I67oz6IOvMeiMLH
         UEga8TlpzZDJk4j7wkTnxXinsbNke+WusiC4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=R/sETvbdaq4Q2s0fRcKl57m8/bLHDC8VJGGhqi4+XeshT2ZqEcArzGSlrm8DB16A9U
         urUt+hZbQpt55DtiPjPQ3UTQJZ4SIJ6PCliwEWqyGlWm2769NdsKFbituctqQ4aWmvWE
         fGeqHKKSHvn7dSGNgQ2KykWNNkzE+2aNrvIu0=
Received: by 10.239.164.83 with SMTP id s19mr484259hbd.110.1243267812642; Mon, 
	25 May 2009 09:10:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119942>

I've been messing around a bit, trying to set up a gitosis repo to
mirror one of my projects. Now, I added the remote to my project, but
when running "git remote show <remote-name>", I'm getting a segfault
in builtin-remote.c at line 303 ("while (ref->next)"), because ref
itself is NULL. The offending function itself (get_push_ref_states) is
called with NULL as the remote_refs parameters, leading to a
NULL-pointer dereferencing.

Here's the backtrace from the crash:

(gdb) bt
#0  get_push_ref_states (remote_refs=0x0, states=0x27fcdc)
    at builtin-remote.c:303
#1  0x00444301 in get_remote_ref_states (name=0x342bcb "origin_new",
    states=0x27fcdc, query=7) at builtin-remote.c:803
#2  0x004449ae in show (argc=1, argv=0x342d0c) at builtin-remote.c:1004
#3  0x0044593b in cmd_remote (argc=2, argv=0x342d0c, prefix=0x0)
    at builtin-remote.c:1323
#4  0x00401bc7 in run_builtin (p=0x4e8338, argc=3, argv=0x342d0c) at git.c:247
#5  0x00401dab in handle_internal_command (argc=3, argv=0x342d0c) at git.c:392
#6  0x00401ea7 in run_argv (argcp=0x27ff30, argv=0x27ff34) at git.c:438
#7  0x00402036 in mingw_main (argc=3, argv=0x342d0c) at git.c:509
#8  0x00401f12 in main (argc=4, argv=0x342d08) at git.c:456

It appears that the reason for the crash is that get_remote_heads()
(called from transport_get_remote_refs() through
get_refs_via_connect()) returns NULL in list.
Here's my log from stepping through get_remote_heads:

Breakpoint 3, get_remote_heads (in=7, list=0x27fc28, nr_match=0, match=0x0,
    flags=0, extra_have=0x27a127c) at connect.c:59
59              *list = NULL;
(gdb) n
67                      len = packet_read_line(in, buffer, sizeof(buffer));
(gdb) n
68                      if (!len)
(gdb) n
101             return list;
(gdb) n
102     }
(gdb) p list
$13 = (struct ref **) 0x27fc28
(gdb) p list
$14 = (struct ref **) 0x27fc28
(gdb) n
get_refs_via_connect (transport=0x27a1218, for_push=0) at transport.c:640
640             return refs;
(gdb) p refs
$15 = (struct ref *) 0x0

It looks to me like we're failing to read anything from the network
here and don't handle the error correctly, but I don't understand the
code well enough to tell for sure.

My best guess would be that a fix could be something like this, but
I'm not really 100% sure. Doing so makes "git remote show
<remote-name" display something like this

$ /git/git remote show origin_new
* remote remote-name
  URL: USER@HOST:REPONAME.git
  HEAD branch: (unknown)

Which I guess makes sense, since I haven't made any branches on that repo yet.

diff --git a/builtin-remote.c b/builtin-remote.c
index 2ed752c..9ff4b3f 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -793,6 +793,7 @@ static int get_remote_ref_states(const char *name,
                        states->remote->url[0] : NULL);
                remote_refs = transport_get_remote_refs(transport);
                transport_disconnect(transport);
+               if (!remote_refs) return 0;

                states->queried = 1;
                if (query & GET_REF_STATES)

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
