From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] Trivial support for cloning and fetching via ftp://.
Date: Sat, 16 Sep 2006 13:51:31 +0300
Message-ID: <20060916105131.GC17504@sashak.voltaire.com>
References: <20060914022404.GA900@sashak.voltaire.com> <7vk6475408.fsf@assigned-by-dhcp.cox.net> <20060916023717.GA13570@sashak.voltaire.com> <7vwt849nv6.fsf@assigned-by-dhcp.cox.net> <20060916100147.GA17504@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 12:45:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOXgE-0005VI-8P
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 12:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWIPKpl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 06:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWIPKpl
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 06:45:41 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:65067 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1751133AbWIPKpk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 06:45:40 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 16 Sep 2006 13:45:38 +0300
Received: by sashak (sSMTP sendmail emulation); Sat, 16 Sep 2006 13:51:31 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060916100147.GA17504@sashak.voltaire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 16 Sep 2006 10:45:38.0771 (UTC) FILETIME=[3F981A30:01C6D97D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27116>

On 13:01 Sat 16 Sep     , Sasha Khapyorsky wrote:
> On 02:12 Sat 16 Sep     , Junio C Hamano wrote:
> > Sasha Khapyorsky <sashak@voltaire.com> writes:
> > 
> > > Something like this?
> > >
> > > With this change I'm able to clone
> > > ftp://ftp.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> > 
> > I think without you would have, just with extra error messages
> > that http codepath filters out.
> 
> No, not really, without change it fails later:
> 
> $ git-clone ftp://ftp.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> error: RETR response: 550 (curl_result = 19, http_code = 550, sha1 = 63b98080daa35f0d682db04f4fb7ada010888752)
> Getting pack list for ftp://ftp.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
> Getting alternates list for ftp://ftp.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
> Also look at ftp://ftp.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> Getting pack list for ftp://ftp.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> Getting index for pack 477061883bee3d10bece6e3432355b61ba02e594
> error: Unable to find 63b98080daa35f0d682db04f4fb7ada010888752 under ftp://ftp.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
> Cannot obtain needed none 63b98080daa35f0d682db04f4fb7ada010888752
> while processing commit 0000000000000000000000000000000000000000.
> 
> > 
> > > diff --git a/http-fetch.c b/http-fetch.c
> > > index a113bb8..46d6029 100644
> > > --- a/http-fetch.c
> > > +++ b/http-fetch.c
> > > @@ -324,7 +324,9 @@ static void process_object_response(void
> > >  
> > >  	/* Use alternates if necessary */
> > >  	if (obj_req->http_code == 404 ||
> > > -	    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE) {
> > > +	    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE ||
> > > +	    (obj_req->http_code == 550 &&
> > > +	     obj_req->curl_result == CURLE_FTP_COULDNT_RETR_FILE)) {
> > 
> > Here you do the same as the code would for HTTP 404 when you get
> > 550 _and_ RETR failure...
> > 
> > > @@ -538,7 +540,9 @@ static void process_alternates_response(
> > >  		}
> > >  	} else if (slot->curl_result != CURLE_OK) {
> > >  		if (slot->http_code != 404 &&
> > > -		    slot->curl_result != CURLE_FILE_COULDNT_READ_FILE) {
> > > +		    slot->curl_result != CURLE_FILE_COULDNT_READ_FILE &&
> > > +		    (slot->http_code != 550 &&
> > > +		     slot->curl_result != CURLE_FTP_COULDNT_RETR_FILE)) {
> > >  			got_alternates = -1;
> > 
> > ... but you say, while the original code says "declare error if
> > it is not HTTP 404", "oh by the way, if it is 550 _or_ if it
> > is RETR failure then do not trigger this if()".  I suspect you
> > meant to say this?
> > 
> > 	    (slot->http_code != 550 ||
> > 	     slot->curl_result != CURLE_FTP_COULDNT_RETR_FILE)) {
> 
> I think with less strict checking this could be done so, but with _and_
> this also ensures that we are really in FTP mode.

Hmm, saying this I see that original code doesn't do it for specific
case. So for this case we could do:

 	    !(slot->http_code == 550 &&
 	     slot->curl_result == CURLE_FTP_COULDNT_RETR_FILE)) {

Sasha
