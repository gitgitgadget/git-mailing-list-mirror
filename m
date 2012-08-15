From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: URL-decode $my_url/$my_uri when stripping PATH_INFO
Date: Wed, 15 Aug 2012 20:15:48 +0200
Message-ID: <201208152015.49132.jnareb@gmail.com>
References: <1344479366-8957-1-git-send-email-jaysoffian@gmail.com> <7vr4rgoz1u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 20:23:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1iFH-0003hp-F8
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 20:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab2HOSXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 14:23:01 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59614 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab2HOSXA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 14:23:00 -0400
Received: by bkwj10 with SMTP id j10so630797bkw.19
        for <git@vger.kernel.org>; Wed, 15 Aug 2012 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=0oBbwxBD98yA8DhXSmVgzZnem3CWb6bMXm2qD5ghw3A=;
        b=TV1OP2eNobUx95f2LnE3a5rOiZHzHbtkJjNeHIH+zmbTeZpesof1BYXoG7/DXozNaE
         W1SAWoeES9Opy8mPwT/xGvKg2aqXBDxL9IoVP5SIuEX3MtdHqtvVzaG4MTHL1eakgsep
         1uhNpMfvOXLt0ACM+3QWqGV3SEC1pllfPKhRhUFEWVfCBQhTdN/aZc5NgxfJ58K1W+D5
         Vbyv8MF31Pzsk51Rqppb+KBBzSpqhZYpeudpbm8CnxSY968QiMw1dW8IKjKEkmUCjNQG
         MucSIJKN69hDNU63V1xZ/0i7Tp9IZJWIzrZRQs7Qy/6qHg50H6IS75mwhWBWzk1BVUAG
         kftw==
Received: by 10.205.121.132 with SMTP id gc4mr3384416bkc.131.1345054978825;
        Wed, 15 Aug 2012 11:22:58 -0700 (PDT)
Received: from [192.168.1.15] (epk75.neoplus.adsl.tpnet.pl. [83.20.52.75])
        by mx.google.com with ESMTPS id hs2sm1171446bkc.1.2012.08.15.11.22.55
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Aug 2012 11:22:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vr4rgoz1u.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203481>

On Thu, 9 Aug 2012, Junio C Hamano wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > When gitweb is used as a DirectoryIndex, it attempts to strip
> > PATH_INFO on its own, as $cgi->url() fails to do so.
> >
> > However, it fails to account for the fact that PATH_INFO has
> > already been URL-decoded by the web server, but the value
> > returned by $cgi->url() has not been. This causes the stripping
> > to fail whenever the URL contains encoded characters.
> >
> > To see this in action, setup gitweb as a DirectoryIndex and
> > then use it on a repository with a directory containing a
> > space in the name. Navigate to tree view, examine the gitweb
> > generated html and you'll see a link such as:
> >
> >   <a href="/test.git/tree/HEAD:/directory with spaces">directory with spaces</a>
> >
> > When clicked on, the browser will URL-encode this link, giving
> > a $cgi->url() of the form:
> >
> >    /test.git/tree/HEAD:/directory%20with%20spaces
> >
> > While PATH_INFO is:
> >
> >    /test.git/tree/HEAD:/directory with spaces
> >
> > Fix this by calling unescape() on both $my_url and $my_uri before
> > stripping PATH_INFO from them.
> >
> > Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> > ---
> 
> Thanks.  From a cursory look, with the help from the explanation in
> the proposed commit log message, the change looks sensible.
> 
> I wonder if a breakage like this is something we can catch in one of
> the t95xx series of tests, though.

No, it is unfortunately not possible with current test infrastructure
for gitweb.  The gitweb_run from t/gitweb-lib.sh allows to set
PATH_INFO and QUERY_STRING, but does not allow to set up URL.

That might change in the future...

> Jakub, Ack?

Acked-by: Jakub Narebski <jnareb@gmail.com>

Uf ut us bot too late...


-- 
Jakub Narebski
Poland
