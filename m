From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Compute the author/commiter name and email from
	the git configuration
Date: Wed, 4 Feb 2009 09:36:03 -0800
Message-ID: <20090204173603.GC26880@spearce.org>
References: <49898A06.5040603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 18:37:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUlgt-0004uA-IN
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 18:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbZBDRgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 12:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbZBDRgH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 12:36:07 -0500
Received: from george.spearce.org ([209.20.77.23]:45828 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbZBDRgG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 12:36:06 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id DFCBB38210; Wed,  4 Feb 2009 17:36:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49898A06.5040603@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108400>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
> index 34ce04a..113eb1c 100644
> --- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
> @@ -116,4 +120,70 @@ public void test006_readCaseInsensitive() throws IOException {
>  		assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
>  		assertEquals("", repositoryConfig.getString("foo", null, "bar"));
>  	}
> +
> +	private class FakeSystemReader implements SystemReader {
> +		Map<String, String> values = new HashMap<String, String>();
> +		public String getEnvironmentVariable(String variable) {
> +			return values.get(variable);
> +		}
> +		public String getProperty(String key) {
> +			return values.get(key);
> +		}
> +	}

I like this approach.  Perhaps this should simply be done in
RepositoryTestCase so all of our unit tests have a stable default
identity, no matter what.  They could change it on a test-by-test
basis if needed, especially if the reader is created and populated
with default values during the setUp() method.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
> index 8f093d6..372fba5 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
> +
> +	/** The environment variable that contains the commiter's name */
> +	public static final String GIT_COMMITER_NAME_KEY = "GIT_COMMITER_NAME";

There are 2 't's in GIT_COMMITTER_NAME.  Both the variable name
and the value are wrong.

> +	/** The environment variable that contains the commiter's email */
> +	public static final String GIT_COMMITER_EMAIL_KEY = "GIT_COMMITER_EMAIL";

Again, 2 't's.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
> index 7df90cd..0fa4b1f 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
> @@ -308,6 +323,83 @@ public String getString(final String section, String subsection, final String na
...
> +	public String getCommiterName() {

2 't's in comitter.

> +	public String getCommiterEmail() {

There are 2 't's in Committer.

> +	private String getUserEmailInternal(String gitVariableKey, boolean author) {
...
> +			// try to construct an email
> +			String userName = author ? getAuthorName() : getCommiterName();
> +			if (userName != null && userName.length() != 0) {
> +				String hostnameTmp = getHostname();
> +				if (hostnameTmp != null && hostnameTmp.length() != 0) {
> +					email = userName + "@" + hostnameTmp;
> +				}

If you do what I suggest below, getHostname() will never return
null, so this logic will simplify out and we'll always be able to
set email if we have a userName.

Also, I think this should be defaulting to the Java "user.name"
property and not to the GIT_AUTHOR_NAME environment variable.  So if
the user.email isn't set, and the *_EMAIL env var isn't set, use the
"user.name" property and the hostname to form the email address.

I don't think this should ever produce null.  If we don't have a
username from user.name, use some generic string like "unknown-user".
Then we at least still have some identity data.  Its very unlikely
the JVM won't have a "user.name" property for us, so its very
likely we won't get good tests in application level code for null
return values.

> @@ -957,4 +1049,28 @@ private static boolean eq(final String a, final String b) {
> +
> +	/**
> +	 * @return the canonical hostname
> +	 */
> +	public static String getHostname() {

I don't see a reason for this to be public.  Please make it private.

> +		if (hostname == null) {
> +			try {
> +				InetAddress localMachine = InetAddress.getLocalHost();
> +				hostname = localMachine.getCanonicalHostName();
> +			} catch (UnknownHostException e) {
> +				// we do nothing

Set hostname = "localhost" so we don't incur an UHE on every attempt
to get the hostname.  If it failed once, its very likely to fail
again, and again, and again.

> +	/**
> +	 * Overrides the default system reader by a custom one.
> +	 * @param systemReader new system reader
> +	 */
> +	public void setSystemReader(SystemReader systemReader) {

Method should be static.

> +		RepositoryConfig.systemReader = systemReader;

There is no need for RepositoryConfig here.  Rename the parameter
so it doesn't hide the field.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
> new file mode 100644
> index 0000000..89b4021
> --- /dev/null
> +++ b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
> @@ -0,0 +1,24 @@
> +package org.spearce.jgit.util;

Missing copyright header.

> +	/**
> +	 * @param variable system variable to read
> +	 * @return value of the system variable
> +	 */
> +	String getEnvironmentVariable(String variable);

Maybe just emulate the System class and call this getenv() ?

-- 
Shawn.
