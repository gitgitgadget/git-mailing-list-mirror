From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 2/5] quickdiff - Don't add GitDocument as repository listener more than once
Date: Sun, 5 Apr 2009 23:41:15 +0200
Message-ID: <200904052341.15590.robin.rosenberg.lists@dewire.com>
References: <1238697991-12990-1-git-send-email-robin.rosenberg@dewire.com> <1238697991-12990-3-git-send-email-robin.rosenberg@dewire.com> <20090405202400.GO23521@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:42:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqa7E-0006mA-6f
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbZDEVlV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 17:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754774AbZDEVlU
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:41:20 -0400
Received: from mail.dewire.com ([83.140.172.130]:25445 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551AbZDEVlT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 17:41:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 308B21483A0B;
	Sun,  5 Apr 2009 23:41:17 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LBE2pQ1lvT7K; Sun,  5 Apr 2009 23:41:16 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 954B51497A4B;
	Sun,  5 Apr 2009 23:41:16 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090405202400.GO23521@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115720>

s=F6ndag 05 april 2009 22:24:00 skrev "Shawn O. Pearce" <spearce@spearc=
e.org>:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > Doing so was very costly and led to sessions being locked
> > for a long time while refreshing the reference document used
> > by Eclipse's quickdiff feature.
> ...
> > --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> > +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> > @@ -1132,6 +1132,7 @@ public File getWorkDir() {
> >  	 * @param l
> >  	 */
> >  	public void addRepositoryChangedListener(final RepositoryListener=
 l) {
> > +		assert !listeners.contains(l);
> >  		listeners.add(l);
> >  	}
> > =20
> > @@ -1150,6 +1151,7 @@ public void removeRepositoryChangedListener(f=
inal RepositoryListener l) {
> >  	 * @param l
> >  	 */
> >  	public static void addAnyRepositoryChangedListener(final Reposito=
ryListener l) {
> > +		assert !allListeners.contains(l);
> >  		allListeners.add(l);
> >  	}
>=20
> That's a race condition.  The two collections are Vectors so another
> thread can add the listener between your assertion point and the
> add call.

That would be another programming error, to add the same listener from =
different threads. Hopefully it would be caught on the next run. Adding=
 synchronized might be too much since I cannot disable it by disabling =
assert.

> Also, if this really is considered to be very bad behavior on the
> part of the application, maybe these should be real tests with
> exceptions thrown, so they can't be disabled when assertions are
> turned off in the JRE?

It's usually not terribly bad, but what happens isn't well defined. If =
it happens it's a programming error. Especially now that the API bans i=
t.

Asserts are for detecting programming errors during program test. If th=
e tests are good enough there will never be a reason for this assert to=
 fail and so it won't be necessary in deployed code. We could probably =
have lots more of these
declarations of assumptions, most of which would be less obvious than t=
his simple test.

In particular asserts are for detecting bad conditions the programmer c=
ontrols (or should control). Anything that can be the result of user ac=
tions or depending on the runtime environment should have non assert te=
sts.

-- robin
