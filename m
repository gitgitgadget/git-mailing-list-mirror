From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: Question: .idx without .pack causes performance issues?
Date: Mon, 3 Aug 2015 17:17:28 -0500
Message-ID: <CAEtYS8SNksc0m5rn_tRk8bGLBeq_8QcBLHyHo=cOfZ+aE6n0gA@mail.gmail.com>
References: <CAEtYS8QWCg5_DtrJw-e+c50vcG0OpciR6LWon-3GgyngGn+0pQ@mail.gmail.com>
	<xmqq4mkxwd77.fsf@gitster.dls.corp.google.com>
	<xmqqzj2puxu2.fsf@gitster.dls.corp.google.com>
	<xmqqtwsxtey8.fsf@gitster.dls.corp.google.com>
	<CAEtYS8QEuEA6d13FH_0_ZbT9YbJ_UdvhkSBYq1xyGCAuznh-GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:17:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMO34-0004ng-48
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 00:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbbHCWR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 18:17:29 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33909 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbbHCWR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 18:17:29 -0400
Received: by ioea135 with SMTP id a135so158531048ioe.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fOjqpgGehr4QbKHM27i/Q6EhN3fjLT8o7bySbtGgbwc=;
        b=vXIgQEQQOobQmWvkZUJT/VclHj6nv/Ihy7noKtiPB6DeYFffuk2lSqSUF7PDQR9UZq
         d/cJI5U9KC1KKmgZzKqUpxUHKORSMeQ9jDPfmPbhMNbZ/uMuFQz4onaNhXFnqECE0nMf
         XNVaJvz4ngLU3Dp+AS/X4C8JVT1xw+jr40imz4dRlJhOjchM5eosGGYNkZB6sff8iXNT
         h4C+9XG7FnIKLmXJM1DcJY9AgBtntPPGC0DzIqw5S8GlM5NabUab47J/7jBKffpIQDIL
         Az7p8ZtOSZKF5SXaHMnaRRMcrK0rM9n70rUyeOWUjnpehIux9Woi6Ku4dTExQITL3Bzs
         W12A==
X-Received: by 10.107.155.74 with SMTP id d71mr347465ioe.41.1438640248430;
 Mon, 03 Aug 2015 15:17:28 -0700 (PDT)
Received: by 10.79.120.149 with HTTP; Mon, 3 Aug 2015 15:17:28 -0700 (PDT)
In-Reply-To: <CAEtYS8QEuEA6d13FH_0_ZbT9YbJ_UdvhkSBYq1xyGCAuznh-GQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275219>

On Tue, Jul 21, 2015 at 4:37 PM, Doug Kelly <dougk.ff7@gmail.com> wrote:
> On Tue, Jul 21, 2015 at 3:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> While I still think that it is more important to prevent such a
>>> situation from occurring in the first place, ignoring .idx that lack
>>> corresponding .pack should be fairly simple, perhaps like this.
>>> ...
>>
>> Sorry for the noise, but this patch is worthless.  We already have
>> an equivalent test in add_packed_git() that is called from this same
>> place.
>
> And a few extra updates from me: we found that this appears to occur
> even after update to 1.9.5, and setting core.fscache on 2.4.6 has no
> appreciable impact on the time it takes to run "git fetch", either.
> Our thought was antivirus (or something else?) might have the file
> open when git attempts to unlink the .idx, but perhaps it's something
> else, too?  In one case, we had ~560 orphaned .idx files, but 150
> seems sufficient to slow a fetch operation for a few minutes until it
> actually begins transferring objects.
>
> The "git gc" approach to cleaning up the mess is certainly looking
> more and more attractive... :)

Here's a change to prune.c that at least addresses the issue by removing
.idx files without an associated pack, but it's by no means pretty.  If anyone
has any feedback before I turn this into a formal patch, it's more than welcome!

diff --git a/builtin/prune.c b/builtin/prune.c
index 10b03d3..8a60282 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "diff.h"
+#include "dir.h"
 #include "revision.h"
 #include "builtin.h"
 #include "reachable.h"
@@ -85,15 +86,31 @@ static void remove_temporary_files(const char *path)
 {
        DIR *dir;
        struct dirent *de;
+       struct strbuf idx, pack;

        dir = opendir(path);
        if (!dir) {
                fprintf(stderr, "Unable to open directory %s\n", path);
                return;
        }
-       while ((de = readdir(dir)) != NULL)
+       while ((de = readdir(dir)) != NULL) {
                if (starts_with(de->d_name, "tmp_"))
                        prune_tmp_file(mkpath("%s/%s", path, de->d_name));
+               if (ends_with(de->d_name, ".idx")) {
+                       strbuf_init(&idx, 0);
+                       strbuf_init(&pack, 0);
+                       strbuf_addstr(&idx, de->d_name);
+                       strbuf_addbuf(&pack, &idx);
+                       if (strbuf_strip_suffix(&pack, ".idx")) {
+                               strbuf_addstr(&pack, ".pack");
+                               if (!file_exists(mkpath("%s/%s", path,
pack.buf)))
+                                       prune_tmp_file(mkpath("%s/%s",
path, idx.buf));
+                       }
+                       strbuf_release(&idx);
+                       strbuf_release(&pack);
+               }
+
+       }
        closedir(dir);
 }

--
