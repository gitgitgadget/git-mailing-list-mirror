From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH 01/11] Add support code to handle plugin property changes
Date: Thu,  5 Feb 2009 02:00:08 +0100
Message-ID: <1233795618-20249-2-git-send-email-torarnv@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 02:01:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUscO-0000fv-TZ
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 02:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139AbZBEA76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 19:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756269AbZBEA75
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 19:59:57 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:20944 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbZBEA7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 19:59:52 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1574fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 16:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1zKBQqcgBONend2oOSgvYyHVRV9rAC+KVynHIc7Vxig=;
        b=L2mG1Yq4XzDBGFhDyddayrFLd2Ah7/z2voT3CeOki1h0qcPkVJs3pc1f30I/h5rxvk
         ULDwG1FToVqG+tQ8s204foBBwPpUy2z9j3NsQyUqZbBYh/+NXeGUMDrM/+rh/bzEBsK0
         8ot03HilPghlkYtu6knw8ynkiB5ify+G2JCMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oT3IFDSklyEWUvxWC4SIy5COIv137NgIotLvqxaACUBHwp+aB6bWPIp3kq4idLiDw5
         JLxMb4PupX49n/h2OSO3n6v6VnHij7B2//AQgTI3F225r9L6SW0F0nEHTgfdsdBiOmCs
         XXOYqPiT0EhBaglWB9nWcHV50xK9i5CRRMlek=
Received: by 10.86.95.8 with SMTP id s8mr1554428fgb.79.1233795590190;
        Wed, 04 Feb 2009 16:59:50 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 12sm25608fgg.53.2009.02.04.16.59.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 16:59:49 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 5AE01178009; Thu,  5 Feb 2009 02:00:18 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108479>

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../src/org/spearce/egit/ui/Activator.java         |   52 ++++++++++++=
++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java=
 b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
index fced643..d4a9e8e 100644
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
+	public static void addPropertyChangeListener(
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
+	public static void removePropertyChangeListener(
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
+	public static void broadcastPropertyChange(PropertyChangeEvent event)=
 {
+		for (IPropertyChangeListener listener : propertyChangeListeners)
+			listener.propertyChange(event);
+	}
+
 	static class RIRefresh extends Job implements RepositoryListener {
=20
 		RIRefresh() {
--=20
1.6.1.2.309.g2ea3
