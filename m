From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 11/12] Cleanup Config's MAGIC_EMPTY_VALUE to be more safe
Date: Tue, 21 Jul 2009 23:51:21 +0200
Message-ID: <200907212351.21760.robin.rosenberg@dewire.com>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org> <1248207570-13880-11-git-send-email-spearce@spearce.org> <1248207570-13880-12-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 23:51:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTNFP-0001iU-FH
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 23:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241AbZGUVve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 17:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756155AbZGUVvd
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 17:51:33 -0400
Received: from mail.dewire.com ([83.140.172.130]:8861 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756082AbZGUVvb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 17:51:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EAC251481DA8;
	Tue, 21 Jul 2009 23:51:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2fPlaKY7FVTi; Tue, 21 Jul 2009 23:51:24 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 256091481DA7;
	Tue, 21 Jul 2009 23:51:23 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1248207570-13880-12-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123721>

tisdag 21 juli 2009 22:19:29 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> The magic value "%%magic%%empty%%" is just too magic; if it ever
> did appear as a value in a key string Config would have treated
> it as a true value instead of as a string value.  We also had to
> special case conversions of it to the empty string in a string
> context.  Instead we create a special String object using the
> empty string as a template, and use reference equality against
> that to indicate the magic empty value.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  .../src/org/spearce/jgit/lib/Config.java           |   28 +++++++++----------
>  1 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
> index 974ffea..e4528b1 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
> @@ -76,9 +76,14 @@
>  	private Map<String, Object> byName;
>  
>  	/**
> -	 * Magic value indicating a missing entry
> +	 * Magic value indicating a missing entry.
> +	 * <p>
> +	 * This value is tested for reference equality in some contexts, so we
> +	 * must ensure it is a special copy of the empty string.  It also must
> +	 * be treated like the empty string.
>  	 */
> -	private static final String MAGIC_EMPTY_VALUE = "%%magic%%empty%%";
> +	private static final String MAGIC_EMPTY_VALUE = new StringBuilder(0)
> +			.toString();

Can we be sure an implementation doesn't "optimize" toString() here? But an
explicit new String() shouldn't be..?

-- robin



>  	/**
>  	 * The constructor for configuration file
> @@ -293,7 +298,7 @@ public boolean getBoolean(final String section, String subsection,
>  		if (n == null)
>  			return defaultValue;
>  
> -		if (MAGIC_EMPTY_VALUE.equals(n) || "yes".equalsIgnoreCase(n)
> +		if (MAGIC_EMPTY_VALUE == n || "yes".equalsIgnoreCase(n)
>  				|| "true".equalsIgnoreCase(n) || "1".equals(n)
>  				|| "on".equalsIgnoreCase(n)) {
>  			return true;
> @@ -321,11 +326,7 @@ public boolean getBoolean(final String section, String subsection,
>  	 */
>  	public String getString(final String section, String subsection,
>  			final String name) {
> -		String val = getRawString(section, subsection, name);
> -		if (MAGIC_EMPTY_VALUE.equals(val)) {
> -			return "";
> -		}
> -		return val;
> +		return getRawString(section, subsection, name);
>  	}
>  
>  	/**
> @@ -345,16 +346,13 @@ public String getString(final String section, String subsection,
>  		if (o instanceof List) {
>  			final List lst = (List) o;
>  			final String[] r = new String[lst.size()];
> -			for (int i = 0; i < r.length; i++) {
> -				final String val = ((Entry) lst.get(i)).value;
> -				r[i] = MAGIC_EMPTY_VALUE.equals(val) ? "" : val;
> -			}
> +			for (int i = 0; i < r.length; i++)
> +				r[i] = ((Entry) lst.get(i)).value;
>  			return r;
>  		}
>  
>  		if (o instanceof Entry) {
> -			final String val = ((Entry) o).value;
> -			return new String[] { MAGIC_EMPTY_VALUE.equals(val) ? "" : val };
> +			return new String[] { ((Entry) o).value };
>  		}
>  
>  		if (baseConfig != null)
> @@ -700,7 +698,7 @@ protected void printConfig(final PrintWriter r) {
>  				}
>  				r.print(e.name);
>  				if (e.value != null) {
> -					if (!MAGIC_EMPTY_VALUE.equals(e.value)) {
> +					if (MAGIC_EMPTY_VALUE != e.value) {
>  						r.print(" = ");
>  						r.print(escapeValue(e.value));
>  					}
