X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb: Add committags support (take 2)
Date: Mon, 4 Dec 2006 11:33:44 +0100
Message-ID: <200612041133.44816.jnareb@gmail.com>
References: <200612040001.13640.jnareb@gmail.com> <7virgstmg6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 10:32:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UipMDGBeNQqM12UQRWHwlEkVxmGn4Lc9ouls6FstA1ZoIN0DGSLLF3FwX/+lbArXQMLEJHo4+w3g+cuZgU8uzZJu5YhUszcFStrZF21XTeiFURBgqM75PgAgaM0ez1k6c1zKKcGCpEv/j/9yKbt36m1H4OHynEou/p8DqXqTLIg=
User-Agent: KMail/1.9.3
In-Reply-To: <7virgstmg6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33182>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrB73-000805-TQ for gcvg-git@gmane.org; Mon, 04 Dec
 2006 11:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758412AbWLDKbr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 05:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758492AbWLDKbr
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 05:31:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:21710 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1758398AbWLDKbq
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 05:31:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2952738uga for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 02:31:44 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr11708912ugl.1165228303990; Mon, 04
 Dec 2006 02:31:43 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 24sm2633892ugf.2006.12.04.02.31.42; Mon, 04 Dec
 2006 02:31:43 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> The subroutine should return either reference to scalar which means
>> "do not process", scalar which means changed available for further
>> processing, or void (undef) which means no change. In [PATCH 2/3] we
>> will enable returning also list of elements, each of which could be
>> reference to scalar or scalar (for example signoff would return three
>> element list: opening span element as ref, signoff text as scalar,
>> closing span element as ref).
> 
> Personally I think that "list of elements" should be in the
> first patch to build the foundation.

O.K. (By the way, that is why I posted this RFC without sending patch.)
Especially that in this version this is easy and there are no reasons
against it (in previous version %committag entries had 'islink' field,
and returned value was "wrapped" in format_log_line_html in
</a>...<a ...>; I think I'll chose pre-output wrapping <a> elements).

>>   our %committags = (
>>   	'sha1' => {
>>   		'pattern' => qr/[0-9a-fA-F]{40}/,
>>   		'sub' => sub {
>>   			my $hash_text = shift;
>>   			my $type = git_get_type($hash_text);
>>   			if ($type) {
>>   				return \$cgi->a({-href => href(action=>$type, hash=>$hash_text),
>>   				                -class => "text"}, $hash_text);
>>   			}
>>   			return undef;
>>   		},
>>   	},
> 
> It might make sense to do a /[0-9a-f]{8,40}/ pattern, and make
> sure that the named object exists in the sub (which you already
> do).  People often write abbreviated commit object name that has
> a high chance of staying unique during the life of the project.

That's right. I'll do it. By the way, it might make sense to add 
qr/\bv[0-9]+(\.[0-9]+){1,3}(-[a-z]+[0-9]+)\b/ to match "version" tags.

I have one gripe about "git-cat-file -t". I'd like it to have 
-q/--quiet, -s/--silent, --hush (or --dont-spew-errors-on-stdout)
which would prohibit writing "object not found" errors on stderr
(and in gitweb case to webserver logs). I know I can use "git-cat-file -e"
to check if object exists, or modify git_get_type subroutine

  # get type of given object
  sub git_get_type {
	my $hash = shift;
  	my $git_command = git_cmd_str();
  
  	open my $fd, "-|",
  		"$git_command cat-file -t $hash 2>/dev/null"
  		or return '';
  	my $type = <$fd>;
  	close $fd
  		or return '';
  	chomp $type;
  	return $type;
  }

but both those solutions means one fork more.

>>   	'mantis' => {
>>   		'pattern' => qr/(BUG|FEATURE)\(\d+\)/,
>>   	'bugzilla' => {
>>   		'pattern' => qr/bug\s+\d+/,
> 
> This is not wrong per-se but somehow feels funny.  It feels as
> if there is a convention that bugzilla bugs are usually spelled
> in lowercase while mantis bugs are in uppercase, but I do not
> think you are suggesting that.

The Mantis pattern is taken from committags support in gitweb-xmms2,
http://git.xmms.se/?p=gitweb-xmms2.git while Bugzilla pattern is
taken from Mozilla Bugzilla entries.
 
> I do not know how this %committags{} is used per project.  With
> a setting like repo.or.cz, it is likely that one instance of
> gitweb is serving unrelated projects that have their issue
> tracker at different locations using different "committags"
> convention.  Is the idea to eventually allow enabling/disabling
> elements from the global %committags per repository somehow
> (perhaps not just enable/disable but even overriding patterns or
> parameters)?

I have thought about putting %committags and @committags before
loading config file
  do $GITWEB_CONFIG if -e $GITWEB_CONFIG;
which can load config file depending on the project, but perhaps
it is too complicated solution.

Another solution would be to add 'committags' feature, which would
control at least some of the configurable elements of %committags
and @committags (of committags support). At minimum control which
committags are turned on, and in what sequence.

>> 3. To not split message into many fragments we concatenate strings
>> if possible.
> 
> I do not know why "avoiding splits" is needed, if it raises 
> issues that you need to ask the list about in a message like
> this...

"Avoiding splits" is needed first for performance, and second to
avoid situation where pattern would match on the boundary between
two strings in a list of tokens to process.

The improved version of push_or_append follows:

  sub push_or_append (\@@) {
  	my $list = shift;
  
  	if (ref $_[0] || ref $list->[-1] || ! @$list) {
  		return push @$list, @_;
  	} else {
  		my $a = pop @$list;
  		my $b = shift @_;
  
  		return push @$list, $a . $b, @_;
  	}
  }


Or the variant which I wouldn't use ;-P (well, at least not in the
form below).

  sub push_or_append (\@@) {
  	my $aref = shift;
  	my @list = @_;
  
  	try {
  		return push @$aref[0..$#$aref-1],
  		            $aref->[-1] . $list[0],
  		            @list[1..$#list]
  	} catch {
  		return push @$aref, @list;
  	}
  }

-- 
Jakub Narebski
