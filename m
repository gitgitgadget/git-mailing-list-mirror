From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 0/3] Support for loading .gitmodules from blobs
Date: Wed, 24 Jun 2009 17:26:34 -0700
Message-ID: <20090625002634.GI11191@spearce.org>
References: <1245865685-1288-1-git-send-email-constantine.plotnikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 02:26:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJcnc-0001TS-NA
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 02:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041AbZFYA0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 20:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755958AbZFYA0c
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 20:26:32 -0400
Received: from george.spearce.org ([209.20.77.23]:43870 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420AbZFYA0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 20:26:31 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 75E8B381FE; Thu, 25 Jun 2009 00:26:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1245865685-1288-1-git-send-email-constantine.plotnikov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122171>

Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> This series of patches is developed to support accessing 
> .gitmodules file stored inside the repository. This functionality
> is needed for server-side processing of submodules.
> 
> Constantine Plotnikov (3):
>  Extracted functionality independent from .git/config from RepositoryConfig
>  Config.getSubsections(...) now loads the file if it has not been loaded
>  Added BlobBasedConfig that allows accessing configuration files stored in the blobs

Thanks, pushed, with a couple of minor edits that were just easier
to squash in than to ask you to fix and respin:

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java
index 0385a3b..1f44994 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java
@@ -136,10 +136,10 @@ protected InputStream openInputStream() throws IOException {
 			return new ByteArrayInputStream(blobProvider.call());
 		} catch (IOException e) {
 			throw e;
-		} catch (RuntimeException e) {
-			throw e;
 		} catch (Exception e) {
-			throw new RuntimeException(e);
+			final IOException e2 = new IOException("Unable to read config");
+			e2.initCause(e);
+			throw e2;
 		}
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 4220c37..c2d5c6e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -84,8 +84,9 @@
 	 *            the base configuration file to be consulted when value is
 	 *            missing from this file
 	 */
-	public Config(Config base) {
+	protected Config(Config base) {
 		baseConfig = base;
+		clear();
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index a139386..9d2c9a3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -108,7 +108,6 @@ public RepositoryConfig openUserConfig() {
 	 */
 	public RepositoryConfig(final RepositoryConfig base, final File cfgLocation) {
 		super(base, cfgLocation);
-		clear();
 	}
 
 	/**
 
-- 
Shawn.
