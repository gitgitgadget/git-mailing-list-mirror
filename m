From: Mike Hommey <mh@glandium.org>
Subject: Re: [WIP Patch 04/12] Use the new http API in http_fetch_ref()
Date: Sun, 18 Jan 2009 20:21:34 +0100
Organization: glandium.org
Message-ID: <20090118192134.GB23108@glandium.org>
References: <20090118074911.GB30228@glandium.org> <1232265877-3649-1-git-send-email-mh@glandium.org> <1232265877-3649-2-git-send-email-mh@glandium.org> <1232265877-3649-3-git-send-email-mh@glandium.org> <1232265877-3649-4-git-send-email-mh@glandium.org> <1232265877-3649-5-git-send-email-mh@glandium.org> <alpine.DEB.1.00.0901181607210.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 20:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOdEg-0004Ki-4o
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 20:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbZARTVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 14:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbZARTVm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:21:42 -0500
Received: from vuizook.err.no ([85.19.221.46]:58606 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbZARTVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 14:21:41 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOdDD-0004l6-CZ; Sun, 18 Jan 2009 20:21:38 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOdDC-0006TI-Lo; Sun, 18 Jan 2009 20:21:34 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901181607210.3586@pacific.mpi-cbg.de>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106263>

On Sun, Jan 18, 2009 at 04:10:38PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 18 Jan 2009, Mike Hommey wrote:
> 
> > diff --git a/http.c b/http.c
> > index 82534cf..0c9504b 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -604,34 +604,17 @@ int http_fetch_ref(const char *base, struct ref *ref)
> >  {
> >  	char *url;
> >  	struct strbuf buffer = STRBUF_INIT;
> > -	struct active_request_slot *slot;
> > -	struct slot_results results;
> > -	int ret;
> > +	int ret = -1;
> >  
> >  	url = quote_ref_url(base, ref->name);
> > -	slot = get_active_slot();
> > -	slot->results = &results;
> > -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
> > -	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
> > -	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
> > -	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
> > -	if (start_active_slot(slot)) {
> > -		run_active_slot(slot);
> > -		if (results.curl_result == CURLE_OK) {
> > -			strbuf_rtrim(&buffer);
> > -			if (buffer.len == 40)
> > -				ret = get_sha1_hex(buffer.buf, ref->old_sha1);
> > -			else if (!prefixcmp(buffer.buf, "ref: ")) {
> > -				ref->symref = xstrdup(buffer.buf + 5);
> > -				ret = 0;
> > -			} else
> > -				ret = 1;
> > -		} else {
> > -			ret = error("Couldn't get %s for %s\n%s",
> > -				    url, ref->name, curl_errorstr);
> > +	if (http_get_strbuf(url, &buffer, HTTP_NO_CACHE) == HTTP_OK) {
> > +		strbuf_rtrim(&buffer);
> > +		if (buffer.len == 40)
> > +			ret = get_sha1_hex(buffer.buf, ref->old_sha1);
> > +		else if (!prefixcmp(buffer.buf, "ref: ")) {
> > +			ref->symref = xstrdup(buffer.buf + 5);
> > +			ret = 0;
> >  		}
> > -	} else {
> > -		ret = error("Unable to start request");
> >  	}
> 
> Why not keep that error?

It should be handled in http_request, I'd say...

Mike
