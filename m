From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3 00/26] inotify support
Date: Sun, 09 Feb 2014 21:19:08 +0100
Message-ID: <52F7E2BC.5030905@web.de>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com> <1391401754-15347-1-git-send-email-pclouds@gmail.com> <52F5E521.4090707@web.de> <CACsJy8C0x1FL_6KtYj4MMnhtR6RrPSxR6_yysnZykubdotT9GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 09 21:19:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCaqT-0001Uf-0y
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 21:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbaBIUTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 15:19:12 -0500
Received: from mout.web.de ([212.227.15.3]:49570 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbaBIUTK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 15:19:10 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MWS3S-1VjMjW3Cck-00XZb9 for <git@vger.kernel.org>;
 Sun, 09 Feb 2014 21:19:09 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CACsJy8C0x1FL_6KtYj4MMnhtR6RrPSxR6_yysnZykubdotT9GA@mail.gmail.com>
X-Provags-ID: V03:K0:98Z1NCHHKyg3tNoDVaaEZgeBeOczA65ZSQ60Eg7Yb3U1yGhh8j7
 n8hIt3cF/d29terKfltjPvf3DHeyjlNncCFeAr5wG16fabejj7BbB/wctntE/yK39jfv7UU
 nXaUy1vjnKrYafOsHG2kblLGngv1XoYYhBtyg5cW2r4wLHQZtANj1TB8s/ofinEkL/VMl5o
 Oa9dxa255hEdiGnSVWpPA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241884>


On 2014-02-08 09.53, Duy Nguyen wrote:
> Thanks for the comments. I can see I now have some work to do in the
> coming weeks :)
> 


--------------------
>>> file-watcher.c | 32 ++++++++++++++++++++++++++++++++
>>> 1 file changed, 32 insertions(+)
>>
>> I feel a little bit unsure about the 700.
>> Most often Git does not care about permissions,
>> and relies on umask being set appropriatly.
>> (Please correct me if I'm wrong)
>
>Git does care. See credential-cache--daemon.c. In fact this function
>is a copy of check_socket_directory() from that file.
>
I was probably a little bit unclear.
Of course credentials should be protected well and stored with 700.
The rest of the repo could be more loose by using adjust_shared_perm().
Because the whole repo can be shared (or not) and data is visible
to the group or everyone.
(this is a minor issue)

Please see filewatcher.c:
+	if (daemon) {
+		int err;
+		strbuf_addf(&sb, "%s/log", socket_path);
+		err = open(sb.buf, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+		adjust_shared_perm(sb.buf);
(And now we talk about the logfile:
"In daemon mode, stdout and stderr are saved in $WATCHER/log."
It could be nice to make this feature configrable,
either XXX/log or /dev/null.
On the long run we may eat to much disc space on a machine.
The other thing is that we may want to seperate stdout
from stderr, but even this is a low prio comment.


----------------
There is a small issue when I tested on a machine,
where the "data directory" called "daten" is softlinked to another disk:
daten -> /disk3/home2/tb/daten

and the "projects" directory is softlinked to "daten/projects"
projects -> daten/projects/

t7514 fails like this:
--- expect      2014-02-08 14:37:07.000000000 +0000
+++ actual      2014-02-08 14:37:07.000000000 +0000
@@ -1,6 +1,6 @@
 packet:          git> hello
 packet:          git< hello
-packet:          git> index 6cb9741eee29ca02c5b79e9c0bc647bcf47ce948 /home/tb/projects/git/tb/t/trash directory.t7514-file-watcher-lib
+packet:          git> index 6cb9741eee29ca02c5b79e9c0bc647bcf47ce948 /disk3/home2/tb/daten/projects/git/tb/t/trash directory.t7514-file-watcher-lib

Could we use relative path names internally, relative to $GIT_DIR ?


-------------------
Another thing:
Compiling under Mingw gives this:
    LINK git-credential-store.exe
libgit.a(file-watcher-lib.o): In function `connect_watcher':
c:\Dokumente und Einstellungen\tb\projects\git\tb/file-watcher-lib.c:21: undefined reference to `unix_stream_connect'
collect2: ld returned 1 exit status
make: *** [git-credential-store.exe] Error 1

We may need a compiler option like HAS_UNIX_SOCKETS or so.

--------------------------
+++ b/file-watcher.c

+#define INOTIFY_MASKS (IN_DELETE_SELF | IN_MOVE_SELF | \
+		       IN_CREATE | IN_ATTRIB | IN_DELETE | IN_MODIFY |	\
+		       IN_MOVED_FROM | IN_MOVED_TO)
This feels confusing:
a) we have inotify_masks with lower case below.
b) how about INOTIFY_NEEDED_BITS ?
---------------




I'm OK with having the protocol having specified in the
test cases.
One thing that I have on the wish list is to make the
commands/responses more unique, to be able to run grep
on the code base.

One idea could be to use a prefix
"fwr" for "file watcher request" or
"fwr" for "file watcher response".
This does not work, hihi, so

"fwq" for "file watcher reQuest" and
"fwe" for "file watcher rEsponse".
Or 
"ffw" as "from file watcher" and
"tfw" as "to file watcher" for the people who have problems
with left and right, < and > could work.

This is all for today.
I will have a look at different error scenarios, what happens
when the watcher crashes and needs to be restarted,
or when Git itself dies with a segfault and doesn't tell the
watcher.

The easiest way to simulate this would be in terms of test cases.
So I will try to write some
/Torsten
 
