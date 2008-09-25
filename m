From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT RFC PATCH] Improve handling of parsing errors in
	OpenSshConfig
Date: Thu, 25 Sep 2008 08:16:32 -0700
Message-ID: <20080925151632.GN3669@spearce.org>
References: <20080925083934.GB10273@diku.dk> <tQAHDMR4.1222342394.9002900.roro@localhost> <20080925132937.GA16151@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"sverre@rabbelier.nl" <sverre@rabbelier.nl>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Sep 25 17:18:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KisbN-0007Mk-W2
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 17:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbYIYPQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 11:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752732AbYIYPQe
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 11:16:34 -0400
Received: from george.spearce.org ([209.20.77.23]:60895 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbYIYPQd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 11:16:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id ADF393835F; Thu, 25 Sep 2008 15:16:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080925132937.GA16151@diku.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96776>

Jonas Fonseca <fonseca@diku.dk> wrote:
> Badly quoted entries are now ignored similar to how bad port number are
> currently ignored. A check for negative port numbers is now performed
> so that they also will be ignored.
> 
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> 
> ---
>  .../spearce/jgit/transport/OpenSshConfigTest.java  |   46 +++++++++++++++---
>  .../jgit/transport/DefaultSshSessionFactory.java   |   10 +++-
>  .../org/spearce/jgit/transport/OpenSshConfig.java  |   51 ++++++++++++-------
>  3 files changed, 79 insertions(+), 28 deletions(-)

Well, at first glance the new OpenSshConfigException is missing
from the patch.  We need that class to compile correctly.  ;-)
 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
> index 89beab7..123a9b5 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
> @@ -89,7 +90,12 @@
>  	@Override
>  	public synchronized Session getSession(String user, String pass,
>  			String host, int port) throws JSchException {
> -		final OpenSshConfig.Host hc = getConfig().lookup(host);
> +		final OpenSshConfig.Host hc;
> +		try {
> +			hc = getConfig().lookup(host);
> +		} catch (OpenSshConfigException osce) {
> +			throw new JSchException(osce.getMessage());
> +		}

I would perfer to chain the OpenSshConfigException as the cause of
the JSchException.  That way the caller has a chance to give us a
complete stack trace, including the cause of the OSCE being the
inner NumberFormatException or ParseException.

Robin or I will need to edit the EclipseSshSessionFactory to add
this same sort of try/catch.  To keep the tree buildable we'll
want to squash that into your patch.  Yea, sorry, this is where
the egit+jgit within one repository is going to bite us.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
> index b08d5c6..95a37f5 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
> @@ -146,6 +149,10 @@ public Host lookup(final String hostName) {
>  				} finally {
>  					in.close();
>  				}
> +			} catch (NumberFormatException nfe) {
> +				throw new OpenSshConfigException("Parse error", nfe);
> +			} catch (ParseException pe) {
> +				throw new OpenSshConfigException("Parse error", pe);
>  			} catch (FileNotFoundException none) {
>  				hosts = Collections.emptyMap();
>  			} catch (IOException err) {

If we are really going to this level of effort, can we please have
the file path and line number of the invalid line in the exception?

We rarely parse the ~/.ssh/config.  In general its parsed only once
during startup.  Going through a bit more work at parse time to get
more accurate error messages is acceptable.

I think it may be a good idea to have the exception thrown only
when a bad Host block is accessed, or if we try to access an unknown
host and there is an unreadable Host block.

So I'm thinking more like we stuff an OSCE instance into the Host
block if the host has a bad entry, and during get() or lookup()
we test for the exception and rethrow the exception.

E.g. lets say my config file is this:

	$ cat ~/.ssh/config
	Host work
		Hostname internal.google.com"
		Port -1

	Host orcz
		Hostname repo.or.cz
		User spearce
		Port 22

then:

  jgit fetch orcz:foo.git;        # works without error
  jgit fetch work:foo.git;        # throws OSCE due to bad Hostname
  jgit fetch kernel.org:foo.git;  # works as no Host matched

However if my config was more bogus, e.g.:

	$ cat ~/.ssh/config
	Host work"
		User sop

	Host orcz
		Hostname repo.or.cz
		User spearce
		Port 22

then:

  jgit fetch orcz:foo.git;        # still works without error
  jgit fetch work:foo.git;        # fails due to bad Host header
  jgit fetch kernel.org:foo.git;  # fails due to bad Host header

-- 
Shawn.
