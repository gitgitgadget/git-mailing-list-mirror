From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Git segmentation faults if submodule path is empty.
Date: Fri, 16 Aug 2013 09:14:06 -0400
Message-ID: <20130816131406.GC20138@sigill.intra.peff.net>
References: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
 <520DCB4B.6090309@web.de>
 <20130816130957.GB20138@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jharrod LaFon <jlafon@eyesopen.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 16 15:14:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAJr8-000179-Jd
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 15:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab3HPNOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 09:14:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:56471 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791Ab3HPNOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 09:14:09 -0400
Received: (qmail 27401 invoked by uid 102); 16 Aug 2013 13:14:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Aug 2013 08:14:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Aug 2013 09:14:06 -0400
Content-Disposition: inline
In-Reply-To: <20130816130957.GB20138@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232425>

On Fri, Aug 16, 2013 at 09:09:58AM -0400, Jeff King wrote:

> > > -	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name)
> > > +	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name || !value)
> > >  		return 0;
> 
> I think this is also the wrong place to make the check, anyway. It is
> saying that all values of submodule.X.Y must be non-NULL. But that is
> not true. The submodule.X.fetchRecurseSubmodules option can be a
> boolean, and:
> 
>   [submodule "foo"]
>     fetchRecurseSubmodules
> 
> is perfectly valid (and is broken by this patch).

IOW, I think this is the right fix:

diff --git a/submodule.c b/submodule.c
index 3f0a3f9..c0f93c2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -134,6 +134,9 @@ int parse_submodule_config_option(const char *var, const char *value)
 		return 0;
 
 	if (!strcmp(key, "path")) {
+		if (!value)
+			return config_error_nonbool(var);
+
 		config = unsorted_string_list_lookup(&config_name_for_path, value);
 		if (config)
 			free(config->util);
@@ -151,6 +154,9 @@ int parse_submodule_config_option(const char *var, const char *value)
 	} else if (!strcmp(key, "ignore")) {
 		char *name_cstr;
 
+		if (!value)
+			return config_error_nonbool(var);
+
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
 		    strcmp(value, "all") && strcmp(value, "none")) {
 			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);

And new options, as they are added, must decide whether they are boolean
or not (and check !value as appropriate).

-Peff
