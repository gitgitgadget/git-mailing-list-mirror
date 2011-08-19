From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH 0/1] git-clone: fix relative path problem in the alternates
Date: Fri, 19 Aug 2011 13:23:15 +0800
Message-ID: <1313731396-10458-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 07:23:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuHYF-000475-5a
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 07:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab1HSFXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 01:23:21 -0400
Received: from mail.windriver.com ([147.11.1.11]:38378 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab1HSFXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 01:23:21 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p7J5NHLk005539
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 18 Aug 2011 22:23:17 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Thu, 18 Aug 2011 22:23:16 -0700
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179676>

Hi Junio & everyone,

Several days ago, i reported a "git clone" issue, the url is at:
http://marc.info/?l=git&m=131219022632724&w=2

Here i describe the problem again and try to provide a fix for this
problem, please help to review it. Thanks.

The problem:
Suppose we have two git repositories on the local machine, one is
called base repository, another is called source repository, source
repository need refer to some objects of the base repository via
.git/objects/info/alternates. If we set a relative path (source repository
to base repository) in the alternates, we can execute any git commands (branch,
tag, pull, checkout...) successfully in the source repository. But if we
want to clone a destiantion repository from source repository without
"--shared" on the same machine, just like this:
%>git clone $local_path/src_repos $local_path/des_repos
This clone command will fail because git can't get objects of the base
repository.

The reason:
When we execute git clone $local_path/src_repos $local_path/des_repos,
git will copy alternates of the src_repos to the des_repos first, then
des_repos will use this alternates to refer to base repository, this is
the problem, the relative in the alternates is src_repos to base_repos
rather than des_repos to base_repos.

The fix:
After the alternates is copied from src_repos to des_repos and before this
file is used by the des_repos, we can parse it and replace all relative
paths to a corrected path (absolute path of base_repos or new relative path
of des_repos to base_repos). In my patch, i choose to replace relative paths
to absoulte paths of base_repos.

If we add "--shared", this problem doesn't exist becase git doesn't need to
copy alternates, if we add prefix before src_repos like "file://", "git://"...,
this problem also doesn't exist. So i add a function to replace relative paths
in the clone_local(), this only affect git clone $local_path/src_repos
$local_path/des_repos without "--shared" and it has replative paths in the
alternates of src_repos, for other situation, this function will not introduce
any changes. Below is a execution result example of my fix:

the content of the alternates in the source repos (4 lines):
$<relative_path1_source_repos_to_base1>
$<relative_path2_source_repos_to_base2>
# comment line
$<absolute_path_of_base3>

After clone from source repos, the content of the alternates in the des_repos (4 lines):
$<absolute_path_of_base1>
$<absolute_path_of_base2>
# comment line
$<absolute_path_of_base3> 
