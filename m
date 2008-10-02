From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Thu, 2 Oct 2008 11:43:04 +0200
Message-ID: <cb7bb73a0810020243v37759f79xfde4c32c49e1a375@mail.gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200810021059.19708.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 11:44:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlKjS-0005mK-0q
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 11:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbYJBJnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 05:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbYJBJnJ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 05:43:09 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:37584 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbYJBJnG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 05:43:06 -0400
Received: by yx-out-2324.google.com with SMTP id 8so162170yxm.1
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 02:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=F25v49ctpkUAv0HBY+VmfqGwaZncYMxBfoF0IL2UqgQ=;
        b=f3wrYMNKP14YKKAPRBTAqrxP6qMpx1nOEEp3ymtfhFiqm+8bEHYd9e9yRuNVJcyNx7
         cDmcaEiVqpuWrAwlRponxpl5r08MX/qk6tW+OIvcHBR4qABwopGr/tY7OB0SMzX2JWtD
         Np6XUFgCCNPgguFiylyKwb8zTk3SDP1Fx0Adc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EN4twnPVOvbA7pWmynOrWntiyyNZzDqZ0WiC+Vm8tR+j1t1jLG1or8EC31eETjpxC0
         tRDD5n8YWOef4nNZFq9jPVJHa6sumCBmN0EzXXuqlNgPQN6BWSxvb74F0H9hOQ4EFY2O
         8ieB23CHkfpvnXnxcFz6uBUVwCHbKaYzZIRjA=
Received: by 10.90.69.7 with SMTP id r7mr10407984aga.16.1222940584436;
        Thu, 02 Oct 2008 02:43:04 -0700 (PDT)
Received: by 10.90.29.8 with HTTP; Thu, 2 Oct 2008 02:43:04 -0700 (PDT)
In-Reply-To: <200810021059.19708.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97301>

On Thu, Oct 2, 2008 at 10:59 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Giuseppe Bilotta wrote:
>>
>> +# dispatch
>> +my %actions = (
>> +     "blame" => \&git_blame,
> [...]
>> +);
>
> I'm not sure if the '# dispatch' comment is correct here now that
> %actions hash is moved away from actual dispatch (selecting action
> to run)

Bingo.

>> @@ -519,9 +550,19 @@ sub evaluate_path_info {
>>       # do not change any parameters if an action is given using the query string
>>       return if $action;
>>       $path_info =~ s,^\Q$project\E/*,,;
>> +
>> +     # next comes the action
>> +     $action = $path_info;
>> +     $action =~ s,/.*$,,;
>
> I would use here pattern matching, but your code is also good and
> doesn't need changing; just for completeness below there is alternate
> solution:
>
> +       $path_info =~ m,^(.*?)/,;
> +       $action = $1;


Yeah, I just followed the existing code style.


>> @@ -534,8 +575,9 @@ sub evaluate_path_info {
>>               $file_name ||= validate_pathname($pathname);
>>       } elsif (defined $refname) {
>>               # we got "project.git/branch"
>
> You meant here
>
>                # we got "project.git/branch" or "project.git/action/branch"

Yes I do.

>> -             $action ||= "shortlog";
>> -             $hash   ||= validate_refname($refname);
>> +             $action    ||= "shortlog";
>> +             $hash      ||= validate_refname($refname);
>> +             $hash_base ||= validate_refname($refname);
>>       }
>>  }
>
> This hunk is IMHO incorrect.  First, $refname is _either_ $hash, or
> $hash_base; it cannot be both.  Second, in most cases (like the case
> of 'shortlog' action, either explicit or implicit) it is simply $hash;
> I think it can be $hash_base when $file_name is not set only in
> singular exception case of 'tree' view for the top tree (lack of
> filename is not an error, but is equivalent to $file_name='/').

OTOH, while setting both $hash and $hash_base has worked fine for me
so far (because the right one is automatically used and apparently
setting the other doesn't hurt), choosing which one to set is a much
hairier case. Do you have suggestions for a better way to always make
it work?

>> @@ -544,37 +586,6 @@ evaluate_path_info();
>>  our $git_dir;
>>  $git_dir = "$projectroot/$project" if $project;
>>
>> -# dispatch
>> -my %actions = (
> [...]
>> -);
>> -
>>  if (!defined $action) {
>>       if (defined $hash) {
>>               $action = git_get_type($hash);
>
> I _think_ the '# dispatch' comment should be left here, and not moved
> with the %actions hash.

I agree.

>> @@ -631,8 +642,15 @@ sub href (%) {
>>       if ($params{-replay}) {
>>               while (my ($name, $symbol) = each %mapping) {
>>                       if (!exists $params{$name}) {
>> -                             # to allow for multivalued params we use arrayref form
>> -                             $params{$name} = [ $cgi->param($symbol) ];
>> +                             # the parameter we want to recycle may be either part of the
>> +                             # list of CGI parameter, or recovered from PATH_INFO
>> +                             if ($cgi->param($symbol)) {
>> +                                     # to allow for multivalued params we use arrayref form
>> +                                     $params{$name} = [ $cgi->param($symbol) ];
>> +                             } else {
>> +                                     no strict 'refs';
>> +                                     $params{$name} = $$name if $$name;
>
> I would _perhaps_ add here comment that multivalued parameters can come
> only from CGI query string, so there is no need for something like:
>
> +                                       $params{$name} = (ref($$name) ? @$name : $$name) if $$name;
>
>> +                             }
>>                       }
>>               }
>>       }
>
> This fragment is a bit of ugly code, hopefully corrected in later patch.
> I think it would be better to have 'refactor parsing/validation of input
> parameters' to be very fist patch in series; I am not sure but I suspect
> that is a kind of bugfix for current "$project/$hash" ('shortlog' view)
> and "$project/$hash_base:$file_name" ('blob_plain' and 'tree' view)
> path_info.

But implementing the path_info parsing first makes the input param
refactoring SO much nicer that I would rather put a comment here
saying "this code sucks: we should rather collect all input
parameters" and then clean it up on the subsequent patch.


-- 
Giuseppe "Oblomov" Bilotta
