From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/4] Use strbuf in http code
Date: Sun, 9 Dec 2007 19:24:08 +0100
Organization: glandium.org
Message-ID: <20071209182408.GA9427@glandium.org>
References: <1197219900-19334-1-git-send-email-mh@glandium.org> <1197219900-19334-2-git-send-email-mh@glandium.org> <7vy7c3pwek.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 19:24:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1QpM-0004ha-NY
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 19:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbXLISYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 13:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbXLISYL
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 13:24:11 -0500
Received: from smtp19.orange.fr ([80.12.242.18]:56494 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbXLISYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 13:24:10 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1924.orange.fr (SMTP Server) with ESMTP id 1B2121C000A5
	for <git@vger.kernel.org>; Sun,  9 Dec 2007 19:24:09 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf1924.orange.fr (SMTP Server) with ESMTP id DEB4B1C000A3;
	Sun,  9 Dec 2007 19:24:08 +0100 (CET)
X-ME-UUID: 20071209182408912.DEB4B1C000A3@mwinf1924.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1Qoy-0002Vo-6N; Sun, 09 Dec 2007 19:24:08 +0100
Content-Disposition: inline
In-Reply-To: <7vy7c3pwek.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67645>

On Sun, Dec 09, 2007 at 10:15:15AM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Also, replace whitespaces with tabs in some places
> >
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> >
> >  While testing this, I noticed 3 things:
> >  - CURL_MULTI makes the code very racy
> >  - a lot of the code doesn't do anything useful without CURL_MULTI
> >  - the code is redundant
> 
> Yeah, there does seem to be a lot of duplicated code that does common
> setup with slightly different request string.
> 
> > @@ -1115,16 +1109,11 @@ static char *quote_ref_url(const char *base, const char *ref)
> >  
> >  int fetch_ref(char *ref, unsigned char *sha1)
> >  {
> > -        char *url;
> > -        char hex[42];
> > -        struct buffer buffer;
> > +	char *url;
> > +	struct strbuf buffer = STRBUF_INIT;
> >  	char *base = remote->url;
> >  	struct active_request_slot *slot;
> >  	struct slot_results results;
> > -        buffer.size = 41;
> > -        buffer.posn = 0;
> > -        buffer.buffer = hex;
> > -        hex[41] = '\0';
> >  
> >  	url = quote_ref_url(base, ref);
> >  	slot = get_active_slot();
> > @@ -1142,9 +1131,9 @@ int fetch_ref(char *ref, unsigned char *sha1)
> >  		return error("Unable to start request");
> >  	}
> >  
> > -        hex[40] = '\0';
> > -        get_sha1_hex(hex, sha1);
> > -        return 0;
> > +	buffer.buf[40] = '\0';
> > +	get_sha1_hex(buffer.buf, sha1);
> > +	return 0;
> >  }
> 
> A conversion like this is worrysome and needs to be rethought I think.
> 
> At least with the old code, we knew hex[40] was a safe location to make
> assignment to, even though we did not check if what it contained made
> sense --- the other end might have had a garbage in that URL (but the
> caller hopefully would be responsible for noticing that).  But with your
> change, I do not think you have that guarantee.  fwrite_buffer() may
> have extended the buffer using strbuf API, but it may have received less
> than what you are expecting, in which case you may not have buf[40]
> touchable for you, no?
> 
> I at the same time think the original code is buggy.  It initializes
> buffer.buffer to the on-stack storage hex[], but lets fwrite_buffer() to
> call xrealloc() on it.

Both codes are also buggy in case the ref is a symbolic ref, and that
happens. I got bitten by this while testing.

Considering the assumption being made that refs are all properly filled
with sha1s, both codes are mostly equally bad.

Fixing the issue would obviously be the subject for another patch.

Mike
