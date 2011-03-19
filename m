From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/remote-helpers: explain capabilities
 first
Date: Fri, 18 Mar 2011 19:29:05 -0500
Message-ID: <20110319002904.GA25155@elie>
References: <20110318174504.GA22332@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 01:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0k2j-0002ht-B4
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 01:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722Ab1CSA3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 20:29:17 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48088 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab1CSA3P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 20:29:15 -0400
Received: by gxk21 with SMTP id 21so1800823gxk.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 17:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mu+u3xN1JuiS4U1H3k2mQnF+rbtlldcqJZbLTPqTTZs=;
        b=Uw5V0ybbjZRZGMosFh6J6wIpKHTRIkgUHr4+2LQofc+7yBS6qG7YrEis+cs8Ot5+Vk
         JtquI8EIyg2AAZZ/KLueGW7Sy00wxayq2VMXvEDzlCy1kImMwljRclDdD2hBTeE28Flm
         iHh2RdgLD3ai/Q+BAaud2HdaaEVrNVaRQhtuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=J3Pp2PnYpVgiuSOt0IZfUoN3zxkEKluj7pF3C+S3xa0tZQ2Lq8PRg2MNNHIEN0REHt
         74x8c35KqGA8ZjXQfk5OQ5mkbchA17oENO7mzC9jp5nYWLTXagaaj1neNvOhOvpy/5O/
         893SZ+2rsHCyqd1UymXbVN1gvSOcZrR8kwMpU=
Received: by 10.151.103.3 with SMTP id f3mr1806381ybm.102.1300494554735;
        Fri, 18 Mar 2011 17:29:14 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id v35sm853004yba.4.2011.03.18.17.29.12
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 17:29:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110318174504.GA22332@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169379>

Hi again,

Sorry for the spam.  Just ran into a quick puzzle:

Jonathan Nieder wrote:

> +'push'::
> +	Can discover remote refs and push local commits and the
> +	history leading up to them to new or existing remote refs.
> ++
> +Supported commands: 'list for-push', 'push'.
[...]
> +'fetch'::
> +	Can discover remote refs and transfer objects reachable from
> +	them to the local object store.
> ++
> +Supported commands: 'list', 'fetch'.
> +
> +'import'::
> +	Can discover remote refs and output objects reachable from
> +	them as a stream in fast-import format.
> ++
> +Supported commands: 'list', 'import'.

In the actual code:

 * "list for-push" is used if:
    - we are scouting out for "refs in common" in preparation for a push;
    - the "push" capability has been advertised.
 * "list" is used in all other cases.
 * in particular, even if no capabilities are advertised, the "list"
   command will be used.

It's been this way since v1.6.6-rc0~22^2~26 (2009-10-30).  Anyway, the
rule doesn't sound very principled --- if the "push" capability is not
advertised, isn't the push going to error out anyway?  Why fall back
to a normal "list" which is likely not to work, either?

One might suggest:

A.
 - if scouting for "refs in common", use "list for-push";
 - otherwise, use "list" without for-push;
 - in all cases, check for an appropriate capability first
   (push/export in the for-push case, fetch/import otherwise)

At first it sounds ok but this one makes for a lousy story when new
capabilities are invented.  If "git remote-helper" only supports
fetching with a "better-import" capability that my copy of git does
not support, I will still try "git ls-remote helper::url" to learn
what I am missing.

B.
 - if scouting for "refs in common", use "list for-push";
 - otherwise, use "list" without for-push;
 - all remote helpers must implement both "list" and "list for-push".

This rule sounds better, and it doesn't seem to break remote-testgit
(which currently only receives "list" commands without "for-push"
because it only advertises "export" and not "push").  What do you
think?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Probably I confused myself too far after reading in the manpage that
for-push is an attribute.  Note to self: it isn't.

 transport-helper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 0c5b1bd..6d3d15e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -802,7 +802,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 		return transport->get_refs_list(transport, for_push);
 	}
 
-	if (data->push && for_push)
+	if (for_push)
 		write_str_in_full(helper->in, "list for-push\n");
 	else
 		write_str_in_full(helper->in, "list\n");
-- 
1.7.4.1
