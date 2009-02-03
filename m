From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Compute the author/commiter name and email from
	the git configuration
Date: Tue, 3 Feb 2009 15:13:57 -0800
Message-ID: <20090203231357.GZ26880@spearce.org>
References: <1233695594.8042.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 00:15:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUUI-0003br-6i
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbZBCXOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbZBCXN7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:13:59 -0500
Received: from george.spearce.org ([209.20.77.23]:56582 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbZBCXN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:13:58 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E7AA538210; Tue,  3 Feb 2009 23:13:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1233695594.8042.6.camel@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108264>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> index 7df90cd..5821f83 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
> @@ -50,6 +50,8 @@
>  import java.io.InputStreamReader;
>  import java.io.OutputStreamWriter;
>  import java.io.PrintWriter;
> +import java.net.InetAddress;
> +import java.net.UnknownHostException;
>  import java.util.ArrayList;
>  import java.util.Collections;
>  import java.util.HashMap;
> @@ -98,6 +100,8 @@ public static RepositoryConfig openUserConfig() {
>  
>  	private Map<String, Object> byName;
>  
> +	private String hostname;
> +
>  	private static final String MAGIC_EMPTY_VALUE = "%%magic%%empty%%";
>  
>  	RepositoryConfig(final Repository repo) {
> @@ -308,6 +312,83 @@ public String getString(final String section, String subsection, final String na
>  		return result;
>  	}
>  
> +	/**
> +	 * @return the author name as defined in the git variables
> +	 *         and configurations. If no name could be found, try
> +	 *         to use the system user name instead.
> +	 */
> +	public String getAuthorName() {
> +		return getUsernameInternal(Constants.GIT_AUTHOR_NAME_KEY);
> +	}
> +
> +	/**
> +	 * @return the commiter name as defined in the git variables
> +	 *         and configurations. If no name could be found, try
> +	 *         to use the system user name instead.
> +	 */
> +	public String getCommiterName() {
> +		return getUsernameInternal(Constants.GIT_COMMITER_NAME_KEY);
> +	}
> +
> +	private String getUsernameInternal(String gitVariableKey) {
> +		// try to get the user name from the local and global configurations.
> +		String username = getString("user", null, "name");
> +
> +		if (username == null) {
> +			// try to get the user name for the system property GIT_XXX_NAME 
> +			username = System.getProperty(gitVariableKey);

Shouldn't that be System.getenv()?

> +	private String getUserEmailInternal(String gitVariableKey, boolean author) {
> +		// try to get the email from the local and global configs.
> +		String email = getString("user", null, "email");
> +
> +		if (email == null) {
> +			// try to get the email for the system property GIT_XXX_EMAIL 
> +			email = System.getProperty(gitVariableKey);

Again, System.getenv()?

> +	public String getHostname() {
> +		if (hostname == null) {
> +			InetAddress localMachine;
> +			try {
> +				localMachine = InetAddress.getLocalHost();
> +				hostname = localMachine.getHostName();
> +			} catch (UnknownHostException e) {
> +				// we do nothing
> +			}
> +		}
> +		return hostname;

Do we want getHostName() or getCanonicalHostName() here?

I think we'd want getCanonicalHostName().

Should we be caching this at the RepositoryConfig level, or at the
whole JVM level (in a static).  If the application is long-running
its likely to keep the same RepositoryConfig instance around for
the life of that JVM, so we'd only make this request once.  Thus any
change in hostname while the application is running would probably
not take effect until after restart.  But any long running app is
also likely to access more than one Repository, and thus more than
one RepositoryConfig, so they should at least use consistent names,
even if the underlying hostname has changed.

IMHO, just cache it in a static on first demand.

-- 
Shawn.
