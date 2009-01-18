From: Mike Hommey <mh@glandium.org>
Subject: Re: [WIP Patch 08/12] Use the new http API in
	update_remote_info_refs()
Date: Sun, 18 Jan 2009 20:23:43 +0100
Organization: glandium.org
Message-ID: <20090118192343.GC23108@glandium.org>
References: <1232265877-3649-1-git-send-email-mh@glandium.org> <1232265877-3649-2-git-send-email-mh@glandium.org> <1232265877-3649-3-git-send-email-mh@glandium.org> <1232265877-3649-4-git-send-email-mh@glandium.org> <1232265877-3649-5-git-send-email-mh@glandium.org> <1232265877-3649-6-git-send-email-mh@glandium.org> <1232265877-3649-7-git-send-email-mh@glandium.org> <1232265877-3649-8-git-send-email-mh@glandium.org> <1232265877-3649-9-git-send-email-mh@glandium.org> <alpine.DEB.1.00.0901181615070.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 20:25:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOdGl-00051C-7O
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 20:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbZARTXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 14:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbZARTXv
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:23:51 -0500
Received: from vuizook.err.no ([85.19.221.46]:58619 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318AbZARTXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 14:23:50 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOdFI-0004lX-5U; Sun, 18 Jan 2009 20:23:46 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOdFH-0006WB-F0; Sun, 18 Jan 2009 20:23:43 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901181615070.3586@pacific.mpi-cbg.de>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106264>

On Sun, Jan 18, 2009 at 04:18:16PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 18 Jan 2009, Mike Hommey wrote:
> 
> > 
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> >  http-push.c |   29 ++++++++++-------------------
> >  1 files changed, 10 insertions(+), 19 deletions(-)
> > 
> > diff --git a/http-push.c b/http-push.c
> > index e0b4f5a..7627860 100644
> > --- a/http-push.c
> > +++ b/http-push.c
> > @@ -1960,29 +1960,20 @@ static void update_remote_info_refs(struct remote_lock *lock)
> >  static int remote_exists(const char *path)
> >  {
> 
> Heh, I see where your commit subject comes from, but it should rather 
> mention the function "remote_exists()"...
> 
> >  	char *url = xmalloc(strlen(remote->url) + strlen(path) + 1);
> > -	struct active_request_slot *slot;
> > -	struct slot_results results;
> > -	int ret = -1;
> > +	int ret;
> >  
> >  	sprintf(url, "%s%s", remote->url, path);
> >  
> > -	slot = get_active_slot();
> > -	slot->results = &results;
> > -	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
> > -	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
> > -
> > -	if (start_active_slot(slot)) {
> > -		run_active_slot(slot);
> > -		if (results.http_code == 404)
> > -			ret = 0;
> > -		else if (results.curl_result == CURLE_OK)
> > -			ret = 1;
> > -		else
> > -			fprintf(stderr, "HEAD HTTP error %ld\n", results.http_code);
> > -	} else {
> > -		fprintf(stderr, "Unable to start HEAD request\n");
> > +	switch (http_get_strbuf(url, NULL, 0)) {
> > +	case HTTP_OK:
> > +		ret = 1;
> > +		break;
> > +	case HTTP_MISSING_TARGET:
> > +		ret = 0;
> > +		break;
> > +	default:
> > +		ret = -1;
> >  	}
> 
> Does http_get_strbuf() already show the error?  Not as far as I can see, 
> even if it would make sense, no?  At least you'll have to "return 
> error(...)".

As I said, it has some error handling regressions ;)

Mike
