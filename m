From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 0/2] clone-local fixup
Date: Tue, 23 Aug 2011 11:43:05 +0800
Message-ID: <4E5321C9.4080301@gmail.com>
References: <7vliulun2a.fsf@alter.siamese.dyndns.org> <1314061516-24964-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Hui Wang <jason77.wang@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 05:43:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvhtV-0000fS-M0
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 05:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab1HWDnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 23:43:10 -0400
Received: from mail.windriver.com ([147.11.1.11]:53782 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab1HWDnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 23:43:09 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p7N3h5mr011547
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 22 Aug 2011 20:43:05 -0700 (PDT)
Received: from [128.224.163.220] (128.224.163.220) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Mon, 22 Aug
 2011 20:43:04 -0700
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <1314061516-24964-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179917>

This patch series solved the problem from the root cause. :-)

But there is a little problem in the second patch, i provide an 
incremental patch basing on your second patch, if it is fine to you, it 
is OK to squash this patch to your second patch.


commit 47e890818fdac5f6493cd0bbaf9da350785a2bca
Author: Hui Wang <jason77.wang@gmail.com>
Date:   Tue Aug 23 11:32:26 2011 +0800

    clone: don't change absolute path in the copy_alternates
   
    The source alternates may include empty lines, comment lines, relative
    paths and absolute paths. Absolute paths don't need to be changed
    before added to the destination alternates.
   
    Signed-off-by: Hui Wang <jason77.wang@gmail.com>

diff --git a/builtin/clone.c b/builtin/clone.c
index 2842707..284e325 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -258,6 +258,10 @@ static void copy_alternates(struct strbuf *src, 
struct strbuf *dst,
                char *abs_path, abs_buf[PATH_MAX];
                if (!line.len || line.buf[0] == '#')
                        continue;
+               if (is_absolute_path(line.buf)) {
+                       add_to_alternates_file(line.buf);
+                       continue;
+               }
                abs_path = mkpath("%s/objects/%s", src_repo, line.buf);
                normalize_path_copy(abs_buf, abs_path);
                add_to_alternates_file(abs_buf);


Regards,
Hui.

Junio C Hamano wrote:
> So I ended up tackling this myself. I didn't bother moving the
> add_to_alternates_file(), though.
>
> Junio C Hamano (2):
>   clone: allow more than one --reference
>   clone: clone from a repository with relative alternates
>
>  builtin/clone.c  |   82 +++++++++++++++++++++++++++++++++++++++++------------
>  sha1_file.c      |    2 +-
>  t/t5601-clone.sh |   23 +++++++++++++++
>  3 files changed, 87 insertions(+), 20 deletions(-)
>
>   
