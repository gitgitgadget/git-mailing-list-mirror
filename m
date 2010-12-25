From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v7 2/9] gitweb: use eval + die for error (exception) handling
Date: Sun, 26 Dec 2010 00:17:55 +0100
Message-ID: <201012260017.56306.jnareb@gmail.com>
References: <20101222234843.7998.87068.stgit@localhost.localdomain> <20101222235525.7998.99816.stgit@localhost.localdomain> <20101223020801.GB14585@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 26 00:18:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWdNZ-0002KZ-7j
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 00:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107Ab0LYXSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Dec 2010 18:18:08 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51433 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab0LYXSH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Dec 2010 18:18:07 -0500
Received: by bwz15 with SMTP id 15so8873199bwz.19
        for <git@vger.kernel.org>; Sat, 25 Dec 2010 15:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4CWitWXwi/ouSO60QYbg9OR/TMMvv23oviDb2H1ZL9Y=;
        b=oOv9xG2Nth5T9QKoZh3ZIBY4hz+2GNnjwELfqHo6cxtnsQi1ht8KDB7n6Dx8VuzOcJ
         MAGuUXVr/iiF3lMgM2XWsG5bMPHauFawTxsGJqUQn7TNlde692rOzMpUdfs3mYp6Bsn6
         sthA1St2mPGuh1goEqycLz9W6uqzQFOJBMwZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jSenHOrhxxFy34IEHdCrguQaAqWQ+8BH7GpAuBA+tZ5Oa+woREmMiIjYofYLizlZTb
         kisw1S6zCz/OqnkaomcwgwpQ/8FgU3BZ+PMzHjNYQGMNWA4nD/4uFlYrQJSFEWvGo05n
         Bn7ffuu62yDyebym9jr7QAq4ReQLG7VFmGtQM=
Received: by 10.204.82.84 with SMTP id a20mr9299606bkl.154.1293319084966;
        Sat, 25 Dec 2010 15:18:04 -0800 (PST)
Received: from [192.168.1.13] (abwd176.neoplus.adsl.tpnet.pl [83.8.227.176])
        by mx.google.com with ESMTPS id x38sm5569871bkj.1.2010.12.25.15.18.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Dec 2010 15:18:03 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101223020801.GB14585@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164183>

On Thu, 23 Dec 2010, Jonathan Nieder wrote:
> Jakub Narebski wrote:
> 
> > Gitweb assumes here that exceptions thrown by Perl would be simple
> > strings; die_error() throws hash reference (if not for minimal
> > external dependencies, it would be probable object of Class::Exception
> > or Throwable class thrown).
> 
> Hmm, why not throw an object of new type Gitweb::Exception?

First, 'gitweb: Prepare for splitting gitweb' commit is only later in
series... ;-) but that of course is not a serious issue.

Second, more important is that I'd rather gitweb doesn't go "reinvent
the wheel" route.  I'd rather (re)use Exception::Class (like e.g. 
SVN::Web does it) if we go the OO exception handling route.

But if we are going to use Exception::Class, then we can also use
Try::Tiny, I think.

> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -1045,21 +1045,6 @@ sub configure_gitweb_features {
> >  	}
> >  }
> >  
> > -# custom error handler: 'die <message>' is Internal Server Error
> > -sub handle_errors_html {
> > -	my $msg = shift; # it is already HTML escaped
> > -
> > -	# to avoid infinite loop where error occurs in die_error,
> > -	# change handler to default handler, disabling handle_errors_html
> > -	set_message("Error occured when inside die_error:\n$msg");
> > -
> > -	# you cannot jump out of die_error when called as error handler;
> > -	# the subroutine set via CGI::Carp::set_message is called _after_
> > -	# HTTP headers are already written, so it cannot write them itself
> > -	die_error(undef, undef, $msg, -error_handler => 1, -no_http_header => 1);
> > -}
> > -set_message(\&handle_errors_html);
> > -
> 
> Hoorah!

Yeah, that is very nice.

> >  # dispatch
> >  sub dispatch {
> >  	if (!defined $action) {
> > @@ -1167,7 +1152,11 @@ sub run {
> >  		$pre_dispatch_hook->()
> >  			if $pre_dispatch_hook;
> >  
> > -		run_request();
> > +		eval { run_request() };
> > +		if (defined $@ && !ref($@)) {

Ooops, it should be 'if ($@ ...)', not 'if (defined $@ ...)'.

> > +			# some Perl error, but not one thrown by die_error
> > +			die_error(undef, undef, $@, -error_handler => 1);
> > +		}
> 
> The !ref($@) seems overzealous, which is why I am wondering if it
> would be possible to use bless() for a finer-grained check.

You meant Scalar::Util::blessed here, isn't it? Fortunately Scalar::Util
is core Perl module.

By 'overzealous' do you mean here possibility of catching what we 
shouldn't, i.e. non-gitweb error (not thrown by die_error)?  We can
narrow it to "ref($@) eq 'HASH'", but I don't think it would be ever
necessary: Perl throws string exceptions.

> >  
> >  	DONE_REQUEST:
> >  		$post_dispatch_hook->()
> > @@ -3768,7 +3757,8 @@ EOF
> >  	print "</div>\n";
> >  
> >  	git_footer_html();
> > -	goto DONE_REQUEST
> > +
> > +	die {'status' => $status, 'error' => $error}
> >  		unless ($opts{'-error_handler'});
> 
> Is the DONE_REQUEST label still needed?

No it isn't.

> Thanks, I am happy to see the semantics becoming less thorny.

Now I should check if this doesn't affect gitweb performance too badly.
IIRC I have chosen 'goto DONE_GITWEB' because I didn't know about 
ModPerl::Registry redefining 'exit' (why it was done), and because of
some microbenchmark showing that it performs better than die/eval (why
this specific solution)...

But I think that the performance hit would be negligible in practice;
making gitweb more maintainable is I think worth the cost.

-- 
Jakub Narebski
Poland
