From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Thu, 28 Mar 2013 08:49:25 -0700
Message-ID: <20130328154925.GA16034@leaf>
References: <1364446721-13351-1-git-send-email-jkoleszar@google.com>
 <7v7gksjc3v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Koleszar <jkoleszar@google.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:30:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFiP-00080J-Fg
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457Ab3C1Q3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:29:45 -0400
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:38836 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756336Ab3C1Q3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:29:44 -0400
X-Greylist: delayed 1718 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2013 12:29:44 EDT
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 6CF5247A8A0
	for <git@vger.kernel.org>; Thu, 28 Mar 2013 16:49:55 +0100 (CET)
Received: from mfilter19-d.gandi.net (mfilter19-d.gandi.net [217.70.178.147])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id F1E7941C076;
	Thu, 28 Mar 2013 16:49:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter19-d.gandi.net
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
	by mfilter19-d.gandi.net (mfilter19-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id XiB-Luua0dY1; Thu, 28 Mar 2013 16:49:29 +0100 (CET)
X-Originating-IP: 50.43.39.152
Received: from leaf (static-50-43-39-152.bvtn.or.frontiernet.net [50.43.39.152])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E164D41C07B;
	Thu, 28 Mar 2013 16:49:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v7gksjc3v.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219422>

On Wed, Mar 27, 2013 at 11:02:28PM -0700, Junio C Hamano wrote:
> John Koleszar <jkoleszar@google.com> writes:
> 
> > Filter the list of refs returned via the dumb HTTP protocol according
> > to the active namespace, consistent with other clients of the
> > upload-pack service.
> >
> > Signed-off-by: John Koleszar <jkoleszar@google.com>
> > ---
> 
> Looks sane from a cursory read---thanks.
> 
> Josh, any comments?

Looks reasonable; glad to see tests explicitly covering it, as well.

Ideally I'd like to see an additional test against that same namespaced
repository, fetching from a different URL that doesn't set
GIT_NAMESPACE, and verifying that info/refs contains the full set of
namespace-qualified refs from all namespaces.  That would make sure that
particular behavior doesn't regress in the future, since one of the use
cases for namespaced repositories involves fetching the whole combined
repo, for purposes such as backups or replication.

> >  http-backend.c          |  8 +++++---
> >  t/lib-httpd/apache.conf |  5 +++++
> >  t/t5561-http-backend.sh |  4 ++++
> >  t/t556x_common          | 16 ++++++++++++++++
> >  4 files changed, 30 insertions(+), 3 deletions(-)
> >
> > diff --git a/http-backend.c b/http-backend.c
> > index f50e77f..b9896b0 100644
> > --- a/http-backend.c
> > +++ b/http-backend.c
> > @@ -361,17 +361,19 @@ static void run_service(const char **argv)
> >  static int show_text_ref(const char *name, const unsigned char *sha1,
> >  	int flag, void *cb_data)
> >  {
> > +	const char *name_nons = strip_namespace(name);
> >  	struct strbuf *buf = cb_data;
> >  	struct object *o = parse_object(sha1);
> >  	if (!o)
> >  		return 0;
> >  
> > -	strbuf_addf(buf, "%s\t%s\n", sha1_to_hex(sha1), name);
> > +	strbuf_addf(buf, "%s\t%s\n", sha1_to_hex(sha1), name_nons);
> >  	if (o->type == OBJ_TAG) {
> >  		o = deref_tag(o, name, 0);
> >  		if (!o)
> >  			return 0;
> > -		strbuf_addf(buf, "%s\t%s^{}\n", sha1_to_hex(o->sha1), name);
> > +		strbuf_addf(buf, "%s\t%s^{}\n", sha1_to_hex(o->sha1),
> > +		            name_nons);
> >  	}
> >  	return 0;
> >  }
> > @@ -402,7 +404,7 @@ static void get_info_refs(char *arg)
> >  
> >  	} else {
> >  		select_getanyfile();
> > -		for_each_ref(show_text_ref, &buf);
> > +		for_each_namespaced_ref(show_text_ref, &buf);
> >  		send_strbuf("text/plain", &buf);
> >  	}
> >  	strbuf_release(&buf);
> > diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> > index 938b4cf..ad85537 100644
> > --- a/t/lib-httpd/apache.conf
> > +++ b/t/lib-httpd/apache.conf
> > @@ -61,6 +61,11 @@ Alias /auth/dumb/ www/auth/dumb/
> >  	SetEnv GIT_COMMITTER_NAME "Custom User"
> >  	SetEnv GIT_COMMITTER_EMAIL custom@example.com
> >  </LocationMatch>
> > +<LocationMatch /smart_namespace/>
> > +	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
> > +	SetEnv GIT_HTTP_EXPORT_ALL
> > +	SetEnv GIT_NAMESPACE ns
> > +</LocationMatch>
> >  ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
> >  ScriptAlias /broken_smart/ broken-smart-http.sh/
> >  <Directory ${GIT_EXEC_PATH}>
> > diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
> > index b5d7fbc..5a19d61 100755
> > --- a/t/t5561-http-backend.sh
> > +++ b/t/t5561-http-backend.sh
> > @@ -134,6 +134,10 @@ POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
> >  ###
> >  GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
> >  POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
> > +
> > +###  namespace test
> > +###
> > +GET  /smart_namespace/repo.git/info/refs HTTP/1.1 200
> >  EOF
> >  test_expect_success 'server request log matches test results' '
> >  	sed -e "
> > diff --git a/t/t556x_common b/t/t556x_common
> > index 82926cf..cb9eb9d 100755
> > --- a/t/t556x_common
> > +++ b/t/t556x_common
> > @@ -120,3 +120,19 @@ test_expect_success 'http.receivepack false' '
> >  	GET info/refs?service=git-receive-pack "403 Forbidden" &&
> >  	POST git-receive-pack 0000 "403 Forbidden"
> >  '
> > +test_expect_success 'backend respects namespaces' '
> > +	log_div "namespace test"
> > +	config http.uploadpack true &&
> > +	config http.getanyfile true &&
> > +
> > +	GIT_NAMESPACE=ns && export GIT_NAMESPACE &&
> > +	git push public master:master &&
> > +	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> > +		git for-each-ref | grep /$GIT_NAMESPACE/ >/dev/null
> > +	) &&
> > +
> > +	git ls-remote public >exp &&  
> > +	curl "$HTTPD_URL/smart_namespace/repo.git/info/refs" >act &&
> > +	test_cmp exp act &&
> > +	(grep /ns/ exp && false || true)
> > +'
