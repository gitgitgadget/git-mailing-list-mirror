From: Tony Finch <dot@dotat.at>
Subject: Re: What's cooking in git.git (Jul 2015, #01; Wed, 1)
Date: Wed, 22 Jul 2015 11:05:04 +0100
Message-ID: <alpine.LSU.2.00.1507220957350.16350@hermes-1.csi.cam.ac.uk>
References: <xmqqzj3f5wtr.fsf@gitster.dls.corp.google.com> <55AE8ACF.6090508@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-1596965037-1437559504=:16350"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Tony Finch <dot@dotat.at>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 12:05:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHqtp-0004pC-5a
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 12:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933599AbbGVKFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 06:05:11 -0400
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:40956 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933303AbbGVKFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 06:05:09 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:45703)
	by ppsw-51.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1ZHqtc-0003qi-Y5 (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 22 Jul 2015 11:05:04 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1ZHqtc-0002lm-Ga (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 22 Jul 2015 11:05:04 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <55AE8ACF.6090508@gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274440>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-1596965037-1437559504=:16350
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>

Thanks for the review!

> > * tf/gitweb-project-listing (2015-03-19) 5 commits
> >  - gitweb: make category headings into links when they are directories
> >  - gitweb: optionally set project category from its pathname
> >  - gitweb: add a link under the search box to clear a project filter
> >  - gitweb: if the PATH_INFO is incomplete, use it as a project_filter
> >
> >  Update gitweb to make it more pleasant to deal with a hierarchical
> >  forest of repositories.

By the way, you can see this patch series in action at
https://git.csx.cam.ac.uk/x/ucs/

> Second one, "gitweb: if the PATH_INFO is incomplete, use it as a
> project_filter" looks interesting and quite useful. Though it doesn't
> do much: it allows for handcrafted URL, and provides mechanism to
> create breadcrumbs. It doesn't use this feature in its output...
> Well, I think it doesn't: I cannot check it at this moment.

Hmm, I think this means I need a better commit message.

This patch fixes the ugly query-parameter URLs in the breadcrumbs that
you get even in path-info mode. Have a look at the breadcrumbs on the
following pages:

https://git.csx.cam.ac.uk/g/ucs/git/git.git (unpatched)
https://git.csx.cam.ac.uk/x/ucs/git/git.git (patched)

If you click on the antepenultimate /git/ in the breadcumbs you get query
parameters without the patch and path_info with the patch. With the patch
the breadcrumbs match the URL.

> What is missing is a support for query parameters path, and not only
> path info.

Query parameter support is already present, in the form of project
filters.

> Thought some thought is needed for generating (or not) breadcrumbs
> if path_info is turned off.

That already works in unpatched gitweb.

> The third, "gitweb: add a link under the search box to clear a project
> filter" notices a problem... then solves it in strange way. IMVHO
> a better solution would be to add "List all projects" URL together
> with " / " (or other separator) conditionally, if $project_filter
> is set. Or have "List all projects" and add "List projects$limit"
> if $project_filter is set.

Yes, that is exactly what the patch does. I used a suffix "if" to align
the print statements and markup:
+           if $project_filter;

Compare and contrast the search box on these pages:

https://git.csx.cam.ac.uk/g/ucs/?a=3Dproject_list;pf=3Du/fanf2
https://git.csx.cam.ac.uk/x/ucs/u/fanf2/

Perhaps you would prefer the following?

--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5549,10 +5549,14 @@ sub git_project_search_form {
              "</span>\n" .
              $cgi->submit(-name =3D> 'btnS', -value =3D> 'Search') .
              $cgi->end_form() . "\n" .
-             $cgi->a({-href =3D> href(project =3D> undef, searchtext =3D> =
undef,
-                                    project_filter =3D> $project_filter)},
-                     esc_html("List all projects$limit")) . "<br />\n";
-       print "</div>\n";
+             $cgi->a({-href =3D> $my_uri}, esc_html("List all projects"));
+       if ($project_filter) {
+               print " / " .
+                   $cgi->a({-href =3D> href(project =3D> undef, action =3D=
> "project_list",
+                                          project_filter =3D> $project_fil=
ter)},
+                           esc_html("List projects$limit"));
+       }
+       print "<br />\n</div>\n";
 }

 # entry for given @keys needs filling if at least one of keys in list

> The last two, which form the crux of this patch series, looks like
> a good idea, though not without a few caveats. I am talking here
> only about conceptual level, not about how it is coded (which has
> few issues as well):
>
> - I think that non-bare repositories "repo/.git" should be
>   treated as one directory entry, i.e. gitweb should not create
>   a separate category for "repo/".  This is admittedly a corner
>   case, but useful for git-instaweb

Yes, that's a bug, thanks for spotting it!

> - I think that people would want to be able to configure how
>   many levels of directory hierarchy gets turned into categories.
>   Perhaps only top level should be turned into category? Deep
>   hierarchies means deep categories (usually with very few
>   repositories) with current implementation.

Good question. I was assuming flat-ish directory hierarchies, but that's
clearly not very true, e.g. https://git.kernel.org/cgit/

I think it would be right to make this a %feature since categories already
nearly fit the %feature per-project override style.

I will send a new version of the series shortly.

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Viking, North Utsire: Westerly 4 or 5, occasionally 6 at first, backing
southerly 3 or 4. Moderate becoming slight. Occasional rain in north. Good,
occasionally moderate.
--1870869256-1596965037-1437559504=:16350--
