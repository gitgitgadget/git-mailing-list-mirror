From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Introduce the function strip_path_suffix()
Date: Wed, 18 Feb 2009 22:13:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902182211550.10279@pacific.mpi-cbg.de>
References: <cover.1234969572u.git.johannes.schindelin@gmx.de> <7b5ee74d497bbb7144b8683725cd83c8bbd33f9a.1234969572u.git.johannes.schindelin@gmx.de> <499C63E7.5040306@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 22:14:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZtjv-0006b5-Dz
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 22:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbZBRVMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 16:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbZBRVMY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 16:12:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:44966 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751628AbZBRVMX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 16:12:23 -0500
Received: (qmail invoked by alias); 18 Feb 2009 21:12:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 18 Feb 2009 22:12:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ltZ1Xjd3lCcawFlJ3dtxNS6FhOJtEcRBAkSjMtk
	iWxhZD/pvbPpru
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <499C63E7.5040306@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110577>

Hi,

On Wed, 18 Feb 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > The function strip_path_suffix() will try to split the given path into 
> > prefix/suffix.  The suffix has to be passed to the function, and if 
> > the path matches, the prefix is set.
> > 
> > Arbitrary runs of directory separators ("slashes") are assumed 
> > identical.
> > 
> > Example:
> > 
> >  strip_path_suffix("C:\\msysgit/\\libexec\\git-core",
> >   "libexec///git-core", &prefix)
> > 
> > will set prefix to "C:\\msysgit" and return 0.
> 
> But you implemented it so that prefix is actually "C:\\msysgit/\\" 
> (unless, of course, I'm reading the code wrong).

This is supposed to handle that case:

	*prefix = xstrndup(path, chomp_trailing_dir_sep(path, path_len));

> > +/* sets prefix if the suffix matches */
> > +int strip_path_suffix(const char *path, const char *suffix, const char
> > **prefix)
> 
> For a general purpose function, the API is very unnatural (and geared 
> towards its only user in patch 2/2). I'd expect that the return value is 
> the result or NULL on failure.

Good point.  Will change.

> > +{
> > +	int path_len = strlen(path), suffix_len = strlen(suffix);
> > +
> > +	while (suffix_len) {
> > +		if (!path_len)
> > +			return 1;
> > +
> > +		if (is_dir_sep(path[path_len - 1])) {
> > +			if (!is_dir_sep(suffix[suffix_len - 1]))
> > +				return 1;
> > +			path_len = chomp_trailing_dir_sep(path, path_len);
> > +			suffix_len = chomp_trailing_dir_sep(suffix,
> > suffix_len);
> > +		}
> > +		else if (path[--path_len] != suffix[--suffix_len])
> > +			return 1;
> > +	}
> > +
> > +	if (path_len && !is_dir_sep(path[path_len - 1]))
> > +		return 1;
> 
> Should strip_path_suffix("foo/bar", "foo/bar", &prefix) succeed and 
> prefix be the empty string? This implementation says it should be so. 
> That's just a question...

Yes, I assumed that that makes sense.

Ciao,
Dscho
