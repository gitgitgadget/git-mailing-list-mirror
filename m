From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 2/4] gitweb: git_get_heads_list accepts an optional list of refs.
Date: Mon, 17 Nov 2008 02:09:54 +0100
Message-ID: <200811170209.54696.jnareb@gmail.com>
References: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com> <1226842089-1159-3-git-send-email-giuseppe.bilotta@gmail.com> <7vod0f37gr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 02:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1se2-0007Ua-DJ
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 02:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbYKQBJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 20:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbYKQBJ6
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 20:09:58 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:27371 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbYKQBJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 20:09:57 -0500
Received: by ey-out-2122.google.com with SMTP id 6so867547eyi.37
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 17:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=u8qfwsosh61aQDxXC8TR8a+0OyJKY9VRWHpK20XPVWY=;
        b=JUPrjTA2fwyg7T3K9g3rvKYuHNoY7pOxc/tR8sUz9GXT3X//hb7L/m0ZUyjgTK1JkZ
         B5JsHZvY3R+ZgoIx0v20YN0veHBcL34/qhCT6CEocHezW5QgkT8jksphzYplRtdmV4n2
         A+Ynf5J21d4ocqR7OvapH/YejW6K31XMfwwxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=U5ZgV9BQJMtty/VVQQPAKKDakooHkUDx5zVIEjfA6Z9gEY7sXlzA6FsinZ5KPdi0ka
         Vy/gBIk5gInrw8r5rXA+wzgSNp1OaFQHzVKHUHD5uWgYVO8/+ruCZTTi8mGpqyd3rofz
         CfkSGsW7FhGrq46VL2Dqc1SCKyzg2SBDo/krQ=
Received: by 10.210.104.20 with SMTP id b20mr3465517ebc.29.1226884195380;
        Sun, 16 Nov 2008 17:09:55 -0800 (PST)
Received: from ?192.168.1.11? (abwi102.neoplus.adsl.tpnet.pl [83.8.232.102])
        by mx.google.com with ESMTPS id 23sm3331773eya.7.2008.11.16.17.09.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 17:09:54 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vod0f37gr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101188>

On Sun, 16 Nov 2008, Junio C Hamano wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
> 
> > git_get_heads_list(limit, class1, class2, ...) can now be used to retrieve
> > refs/class1, refs/class2 etc. Defaults to ('heads') or ('heads', 'remotes')
> > depending on the remote_heads option.
> >
> > Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> > ---
> >  gitweb/gitweb.perl |   11 +++++++----
> >  1 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index e1f81f6..0512020 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -2681,15 +2681,18 @@ sub parse_from_to_diffinfo {
> >  ## parse to array of hashes functions
> >  
> >  sub git_get_heads_list {
> > -	my $limit = shift;
> > +	my ($limit, @class) = @_;
> > +	unless (defined @class) {
> > +		my $remote_heads = gitweb_check_feature('remote_heads');
> > +		@class = ('heads', $remote_heads ? 'remotes' : undef);
> > +	}
> > +	my @refs = map { "refs/$_" } @class;
> 
> Makes sense, except that I'd suggest passing a hash of "refs/$path" =>
> $class as I illustrated in my comments to [1/4], instead of passing a list
> of ("head", "remote"), because that will later allow you to have
> multi-level $path that does not necessarily limited to a $class that is a
> substring of $path, and doing so does not make the code any more complex.
> There is another reason to do so I'll mention in I comment on [3/4].

By the way, with %head_class hash passed as reference git_get_head_list
could be done in such way, that you can write 

  git_get_heads_list(\%head_class);

instead of longer

  git_get_heads_list(undef, \%head_class);

when there is no limit(er).
-- 
Jakub Narebski
Poland
