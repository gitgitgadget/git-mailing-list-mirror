From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH v2 01/12] Add support code to handle plugin property changes
Date: Wed, 11 Feb 2009 19:40:03 +0100
Message-ID: <1234377614-23798-2-git-send-email-torarnv@gmail.com>
References: <1234377614-23798-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:41:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK19-0004zp-7m
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbZBKSje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 13:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbZBKSjd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:39:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:15206 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbZBKSj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:39:29 -0500
Received: by fg-out-1718.google.com with SMTP id 16so108716fgg.17
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 10:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TKlxbnXH1T1YX5I3k/ydbG9mXMBA7HI+2tmjSbBn5kg=;
        b=vuwBCXyYQYC42HrQKEpCPWkVXkPTwnZ5LTUoJEBD/SQZ6iBBDyMA7e3I15ovUUBtl6
         L8zNHnMmGdXfLhZTNc9f2rIlpsgulxTRmjKKUmb33czRGPgVZPgCZre1bL7fsbIahMiy
         Z5QF8bbeiaDs7Dv4Lz+I8yNJUMhUJrh/wG2TM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nxIZdB5sPHZNSIebBHqgQ11rlsJNasXd/1gaEmzHktcU1nl34uzWvJGwjvYhY6uyoW
         8C/YJV9qA75eaQV3Wi79B6Avo57639U2qBPih+sIf/Y0wwvv5TSUwi2KqWujt/OYAhoK
         xulEXSb/PkcvSjrnTjnD5f4+qaTFykYo7Qrtk=
Received: by 10.86.51.2 with SMTP id y2mr876784fgy.2.1234377567695;
        Wed, 11 Feb 2009 10:39:27 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 3sm4854421fge.42.2009.02.11.10.38.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 10:38:54 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id EC970178009; Wed, 11 Feb 2009 19:40:14 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1234377614-23798-1-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109480>

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../src/org/spearce/egit/ui/Activator.java         |   52 ++++++++++++=
++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java=
 b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
index fced643..534c408 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
@@ -10,9 +10,11 @@
=20
 import java.net.Authenticator;
 import java.net.ProxySelector;
+import java.util.ArrayList;
 import java.util.HashSet;
 import java.util.Iterator;
 import java.util.LinkedHashSet;
+import java.util.List;
 import java.util.Set;
=20
 import org.eclipse.core.net.proxy.IProxyService;
@@ -27,6 +29,8 @@
 import org.eclipse.core.runtime.SubProgressMonitor;
 import org.eclipse.core.runtime.jobs.ISchedulingRule;
 import org.eclipse.core.runtime.jobs.Job;
+import org.eclipse.jface.util.IPropertyChangeListener;
+import org.eclipse.jface.util.PropertyChangeEvent;
 import org.eclipse.jsch.core.IJSchService;
 import org.eclipse.swt.graphics.Font;
 import org.eclipse.ui.plugin.AbstractUIPlugin;
@@ -44,9 +48,24 @@
  * This is a plugin singleton mostly controlling logging.
  */
 public class Activator extends AbstractUIPlugin {
+
+	/**
+	 *  The one and only instance
+	 */
 	private static Activator plugin;
=20
 	/**
+	 * Property listeners for plugin specific events
+	 */
+	private static List<IPropertyChangeListener> propertyChangeListeners =
=3D
+		new ArrayList<IPropertyChangeListener>(5);
+
+	/**
+	 * Property constant indicating the decorator configuration has chang=
ed.
+	 */
+	public static final String DECORATORS_CHANGED =3D "org.spearce.egit.u=
i.DECORATORS_CHANGED"; //$NON-NLS-1$
+
+	/**
 	 * @return the {@link Activator} singleton.
 	 */
 	public static Activator getDefault() {
@@ -167,6 +186,39 @@ private void setupRepoIndexRefresh() {
 		Repository.addAnyRepositoryChangedListener(refreshJob);
 	}
=20
+	/**
+	 * Register for changes made to Team properties.
+	 *=20
+	 * @param listener
+	 *            The listener to register
+	 */
+	public static synchronized void addPropertyChangeListener(
+			IPropertyChangeListener listener) {
+		propertyChangeListeners.add(listener);
+	}
+
+	/**
+	 * Remove a Team property changes.
+	 *=20
+	 * @param listener
+	 *            The listener to remove
+	 */
+	public static synchronized void removePropertyChangeListener(
+			IPropertyChangeListener listener) {
+		propertyChangeListeners.remove(listener);
+	}
+
+	/**
+	 * Broadcast a Team property change.
+	 *=20
+	 * @param event
+	 *            The event to broadcast
+	 */
+	public static synchronized void broadcastPropertyChange(PropertyChang=
eEvent event) {
+		for (IPropertyChangeListener listener : propertyChangeListeners)
+			listener.propertyChange(event);
+	}
+
 	static class RIRefresh extends Job implements RepositoryListener {
=20
 		RIRefresh() {
--=20
1.6.1.2.309.g2ea3
