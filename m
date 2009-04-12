From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push.c: DAV must support olny http and https
	scheme
Date: Sun, 12 Apr 2009 11:00:53 +0200
Message-ID: <20090412090053.GA9920@glandium.org>
References: <1239371060-3978-1-git-send-email-catap@catap.ru> <7vd4bi9s1m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kirill A. Korinskiy" <catap@catap.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 11:03:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsvb0-0002mp-GW
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 11:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757612AbZDLJBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 05:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757689AbZDLJBJ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 05:01:09 -0400
Received: from vuizook.err.no ([85.19.221.46]:34379 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757391AbZDLJBH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 05:01:07 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LsvYf-0003Dv-Qg; Sun, 12 Apr 2009 11:01:00 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LsvYb-0002ac-Sj; Sun, 12 Apr 2009 11:00:53 +0200
Content-Disposition: inline
In-Reply-To: <7vd4bi9s1m.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116376>

On Sun, Apr 12, 2009 at 01:48:05AM -0700, Junio C Hamano wrote:
> "Kirill A. Korinskiy" <catap@catap.ru> writes:
> 
> > If the response from remote web-server have scp or other not http-like
> > scheme http-push can't go to change url, because DAV must work only
> > over HTTP (http and https scheme).
> >
> > Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
> > ---
> >  http-push.c |   19 ++++++++++---------
> >  1 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/http-push.c b/http-push.c
> > index feeb340..48c9a04 100644
> > --- a/http-push.c
> > +++ b/http-push.c
> > @@ -1457,16 +1457,17 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
> >  			}
> >  		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
> >  			char *path = ctx->cdata;
> > -			if (*ctx->cdata == 'h') {
> > -				path = strstr(path, "//");
> > -				if (path) {
> > -					path = strchr(path+2, '/');
> > -				}
> > -			}
> > -			if (path) {
> > -				path += repo->path_len;
> > -				ls->dentry_name = xstrdup(path);
> > +			if (!strcmp(ctx->cdata, "http://")) {
> > +				path = strchr(path + sizeof("http://") - 1, '/');
> > +			} else if (!strcmp(ctx->cdata, "https://")) {
> > +				path = strchr(path + sizeof("https://") - 1, '/');
> >  			}
> > +
> > +			path += remote->path_len;
> 
> http-push.c: In function 'handle_remote_ls_ctx':
> http-push.c:1466: error: 'remote' undeclared (first use in this function)
> http-push.c:1466: error: (Each undeclared identifier is reported only once
> http-push.c:1466: error: for each function it appears in.)
> 
> Ah, crap.

s/remote/repo/. He must have done his patch before 7b5201a and rebased
afterwards without checking.

Mike
