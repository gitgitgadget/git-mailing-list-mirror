From: Daniel Johnson <computerdruid@gmail.com>
Subject: [RFC/PATCHv2] fetch: allow command line --tags to override config
Date: Wed, 11 Aug 2010 18:57:20 -0400
Message-ID: <1281567440-6329-1-git-send-email-ComputerDruid@gmail.com>
References: <AANLkTike2mAoGGk2ryZGjOmfT=yjHBLD4W5GPaXkxiso@mail.gmail.com>
Cc: Daniel Johnson <ComputerDruid@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 00:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjKFR-00051b-Kz
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 00:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928Ab0HKW6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 18:58:09 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39759 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab0HKW6G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 18:58:06 -0400
Received: by qwh6 with SMTP id 6so659612qwh.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 15:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=kv+nkHTV7HKK2cPm2/0UxpAb/w6ZJ/cNHAdWZo732+k=;
        b=q+fkAv3HprHHOju25jh8SMYDNDvCWRYHYKIiSylTkoAisRFZFWWAa0LThgtB5mBJr0
         Xe9Qvm1fXDGrvsoYg4UYxk8dso5ACJKGdeecwg+Sa0ZwfPVup9ZczVN2KFpyF585WBdL
         2tulRsL1GuTFlyliNmf9xsGkZjN7s2eoTYubY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oQnHnU7qyzeZ7HAtPSF9+juMr+6OGcRkwG9mmOJ+YQm3evsqMSGq1Bv7kQv97Kcj0W
         jAW0wjI/ReYgX3vlruIdelrMV7irnMCOCDTuzqktkyBXQ2KuDHZsbxc74VONQ+S0g695
         2V2Qv2oFlQXfyBIEnO9/tEtyhAt8+S0W4EOjM=
Received: by 10.224.116.20 with SMTP id k20mr11333912qaq.308.1281567485060;
        Wed, 11 Aug 2010 15:58:05 -0700 (PDT)
Received: from ComputerDruid@gmail.com (pool-71-163-16-224.bltmmd.fios.verizon.net [71.163.16.224])
        by mx.google.com with ESMTPS id t1sm869891qcs.33.2010.08.11.15.58.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 15:58:03 -0700 (PDT)
Received: by ComputerDruid@gmail.com (sSMTP sendmail emulation); Wed, 11 Aug 2010 18:58:15 -0400
X-Mailer: git-send-email 1.7.2
In-Reply-To: <AANLkTike2mAoGGk2ryZGjOmfT=yjHBLD4W5GPaXkxiso@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153310>

Originally, if remote.<name>.tagopt was set, the --tags and option would
have no effect when given to git fetch. So if
tagopt="--no-tags"

	git fetch --tags

would not actually fetch tags.

This patch changes this behavior to only follow what is written in the
config if there is no option passed by the command line.

Signed-off-by: Daniel Johnson <ComputerDruid@gmail.com>
---
On Sat, Aug 7, 2010 at 10:17 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Fri, Aug 6, 2010 at 9:54 PM, Daniel Johnson <computerdruid@gmail.com> wrote:
>> ---
>> How does this look?
>
> Looks ok - now you'll have to squash this with your code patch.
And here it is. Sorry about the lateness. I also fixed a mistake I made in the
documentation (linked to the wrong secton).

I'd still like comments on both the code and the change in behavior behind it.

 Documentation/config.txt        |    4 +++-
 Documentation/fetch-options.txt |    8 ++++++--
 builtin/fetch.c                 |   10 ++++++----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f81fb91..682ebef 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1627,7 +1627,9 @@ remote.<name>.tagopt::
 	Setting this value to \--no-tags disables automatic tag following when
 	fetching from remote <name>. Setting it to \--tags will fetch every
 	tag from remote <name>, even if they are not reachable from remote
-	branch heads.
+	branch heads. Passing these flags directly to linkgit:git-fetch[1] can
+	override this setting. See options \--tags and \--no-tags of
+	linkgit:git-fetch[1].
 
 remote.<name>.vcs::
 	Setting this to a value <vcs> will cause git to interact with
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 9333c42..470ac31 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -49,7 +49,9 @@ ifndef::git-pull[]
 endif::git-pull[]
 	By default, tags that point at objects that are downloaded
 	from the remote repository are fetched and stored locally.
-	This option disables this automatic tag following.
+	This option disables this automatic tag following. The default
+	behavior for a remote may be specified with the remote.<name>.tagopt
+	setting. See linkgit:git-config[1].
 
 -t::
 --tags::
@@ -58,7 +60,9 @@ endif::git-pull[]
 	objects reachable from the branch heads that are being
 	tracked will not be fetched by this mechanism.  This
 	flag lets all tags and their associated objects be
-	downloaded.
+	downloaded. The default behavior for a remote may be
+	specified with the remote.<name>.tagopt setting. See
+	linkgit:git-config[1].
 
 -u::
 --update-head-ok::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1b67f5f..7a53144 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -675,10 +675,12 @@ static int do_fetch(struct transport *transport,
 
 	for_each_ref(add_existing, &existing_refs);
 
-	if (transport->remote->fetch_tags == 2 && tags != TAGS_UNSET)
-		tags = TAGS_SET;
-	if (transport->remote->fetch_tags == -1)
-		tags = TAGS_UNSET;
+	if (tags == TAGS_DEFAULT) {
+		if (transport->remote->fetch_tags == 2)
+			tags = TAGS_SET;
+		if (transport->remote->fetch_tags == -1)
+			tags = TAGS_UNSET;
+	}
 
 	if (!transport->get_refs_list || !transport->fetch)
 		die("Don't know how to fetch from %s", transport->url);
-- 
1.7.2
