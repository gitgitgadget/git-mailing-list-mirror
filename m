From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] My thoughts about implementing gitweb output caching
Date: Sat, 8 Jan 2011 12:44:04 +0100
Message-ID: <201101081244.05287.jnareb@gmail.com>
References: <201101080042.36156.jnareb@gmail.com> <20110108002643.GD15495@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 12:44:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbXDj-0004LL-U6
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 12:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab1AHLoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 06:44:17 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:59182 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab1AHLoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 06:44:16 -0500
Received: by wwi17 with SMTP id 17so255693wwi.1
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 03:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=UKCDZ6zXLkjTPHbz2ob6zrxmI74ghB0p8FGYpUjA2jc=;
        b=TCjlt4cSRH3B+U0PCBuPSLuOUkC4AGv25oX+5TlRph2ODP0Mxd7BOw58z5wPpAW7JE
         q1FawB5iSxy/NTbcgLPQywqBKp1G/6lnOvDRSBNlM2ku7kWoRw/vY76P88mGY9ETSqHw
         msxsfepkmxzYYM+oULVLZ0rGsvOIDOtX3GWfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GcPCXJ1flCRMeDbsAcX/LVoIEfDdzQ18nIv6TZLRg0fLkSGNlsx83oznhM2HIDgMt6
         NQuOPLTS74JiwRM1DO7UiVcPgz+XtJfOK4F74gjzCl0JltY/n3O2HKRroMf7uYJfLOfi
         j+Db3zk3uVZXAy1nuLmkHV1WjaaCv41x+IM6s=
Received: by 10.227.143.18 with SMTP id s18mr16568635wbu.98.1294487054832;
        Sat, 08 Jan 2011 03:44:14 -0800 (PST)
Received: from [192.168.1.13] (abvf4.neoplus.adsl.tpnet.pl [83.8.203.4])
        by mx.google.com with ESMTPS id f35sm18423770wbf.14.2011.01.08.03.44.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Jan 2011 03:44:13 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110108002643.GD15495@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164817>

On Sat, 8 Jan 2011, Jonathan Nieder wrote:
> 
> [...] A few uninformed reactions.

Thanks for your comments.

> Jakub Narebski wrote:
> 
> > There was request to support installing gitweb modules in a separate
> > directory, but that would require changes to "gitweb: Prepare for
> > splitting gitweb" patch (but it is doable).  Is there wider interest
> > in supporting such feature?
> 
> If you are referring to my suggestion, I see no reason to wait on
> that.  The lib/ dir can be made configurable later.

You are right.  Thanks for sanity check.  Though I'd prefer that we get
it right from the first time.

For the record, the changes to support configurable gitweblibdir are:

gitweb/Makefile:
----------------

   gitweblibdir_SQ = $(subst ','\'',$(gitwebdir)/lib)#'

 to

   gitweblibdir ?= $(gitwebdir)/lib
   ...
   gitweblibdir_SQ = $(subst ','\'',$(gitweblibdir))#'


   GITWEB_REPLACE = \
   ...
   	-e 's|++GITWEBLIBDIR++|$(gitweblibdir)|g' \


gitweb/gitweb.perl:
-------------------

   # __DIR__ is taken from Dir::Self __DIR__ fragment
   sub __DIR__ () {
   	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
   }
   use lib __DIR__ . '/lib';

 to

   use lib $ENV{'GITWEBLIBDIR'} || "++GITWEBLIBDIR++";

or something like that


t/gitweb-lib.sh:
----------------

   gitweb_run () {
   ...
   	GITWEBLIBDIR="$GIT_BUILD_DIR/gitweb/lib"
   	export GITWEBLIBDIR

or the change to gitweb config in gitweb_init()

> > Simplest solution is to use $cgi->self_url() (note that what J.H. v8
> > uses, i.e.: "$my_url?". $ENV{'QUERY_STRING'}, where $my_url is just
> > $cgi->url() is not enough - it doesn't take path_info into account).
> >
> > Alternate solution, which I used in my rewrite, is to come up with
> > "canonical" URL, e.g. href(-replay => 1, -full => 1, -path_info => 0);
> > with this solution using path_info vs query parameters or reordering
> > query parameters still gives the same key.
> 
> It is easy to miss dependencies on parts of the URL that are being
> fuzzed out.  For example, the <base href...> tag is only inserted with
> path_info.  Maybe it would be less risky to first use self_url(), then
> canonicalize it in a separate patch?

You are right; it is only in the latest version of my rewrite that
I remembered that <base href=...> must be added also when caching is
enabled (c.f. using always "text/html" content type when caching is
enabled).
 
> > J.H. patches up and including v7, and my rewrite up and including v6,
> > excluded error pages from caching.  I think that the original resoning
> > behind choosing to do it this way was that A.), each of specific error
> > pages is usually accessed only once, so caching them would only take up
> > space bloating cache, but what is more important B.) that you can't
> > cache errors from caching engine.
> 
> Perhaps there is a user experience reason?  If I receive an error page
> due to a problem with my repository, all else being equal, I would
> prefer that the next time I reload it is fixed.  By comparison, having
> to reload multiple times to forget an obsolete non-error response
> would be less aggravating and perhaps expected.

True, there are errors that are transient (e.g. load too high), there are
errors that need webmaster / admin intervention (e.g. no disk space, or
cache permissions problem), and there are errors that are not fixable
(e.g. page not found).
 
> But the benefit from caching e.g. a response from a broken link would
> outweigh that.

The problem is _only_ if there is progress info indicator for set.

The issue you mentioned might be solved if we are able to set cache
expiration time individually (perhaps with the hint from within gitweb),
e.g. by using the fact that we cache HTTP response which can include
'Expires:' or 'Cache-Control: max-age=' header... or by manipulating
mtime.

> > Second is if there is no stale data to serve (or data is too stale), but
> > we have progress indicator.  In this case the foreground process is
> > responsible for rendering progress indicator, and background process is
> > responsible for generating data.  In this case foreground process waits
> > for data to be generated (unless progress info subroutine exits), so
> > strictly spaking we don't need to detach background process in this
> > case.
> 
> What happens when the client gets tired of waiting and closes the
> connection?

Hmmm... I don't know what happens to worker in non-persistent (CGI),
wrapped persistent (mod_perl via ModPerl::Registry, PSGI via gitweb.psgi)
and persistent (FastCGI) environments.  Well, detaching also in the case
of background generation because of progress_info wouldn't hurt, and
could help...


Thanks again for your comments.

Hoping to hear from J,H. soon...
-- 
Jakub Narebski
Poland
