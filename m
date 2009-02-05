From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH v2] Add support code to handle plugin property changes
Date: Thu,  5 Feb 2009 19:22:52 +0100
Message-ID: <1233858172-21289-1-git-send-email-torarnv@gmail.com>
References: <20090205164022.GK26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 19:24:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV8tB-0002hk-KK
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 19:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbZBESWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 13:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbZBESWX
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 13:22:23 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:42371 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbZBESWW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 13:22:22 -0500
Received: by ewy14 with SMTP id 14so676194ewy.13
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 10:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TKlxbnXH1T1YX5I3k/ydbG9mXMBA7HI+2tmjSbBn5kg=;
        b=LcfNwBz1B8ep820ZdJgFhl747YOYW2RZ7S8A1p1WalZZyeVs3bZJkCrfPVNvjvrRLj
         UJ3hOwTdCXSUuxrUfbBZ8j2zgcIxxn0G0LKaHKCz01MleOXp+gTsbo5O/h2ufRvnxGvx
         PFuBeJ60R8I3s1Cy2IM6RjFEV4h+w0TEIRirs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jp1cECoKd2JIE++D6ZDEQhLb4TOtAOCKHC786K4coQyRxcPZ6bWXDDOs4WzAtlLhTE
         Dh26ZltQYJ25P5soqS6cVruXm3JxHkRezqvJ3TEpPkYrbswul64nk1Vd4Q0J/9+5GR9c
         35SIIT4bESKhnRosiM1IHUeIQ6eJaqI8gvYCY=
Received: by 10.103.131.18 with SMTP id i18mr323930mun.120.1233858139302;
        Thu, 05 Feb 2009 10:22:19 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id j2sm1078808mue.24.2009.02.05.10.22.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 10:22:18 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 7AC2E468001; Thu,  5 Feb 2009 19:22:53 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <20090205164022.GK26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108595>

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
