From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Option to omit column with time of the last change
Date: Wed, 4 Apr 2012 16:31:42 +0200
Message-ID: <201204041631.42905.jnareb@gmail.com>
References: <20120403132735.GA12389@camk.edu.pl> <201204040112.02269.jnareb@gmail.com> <20120404063939.GA17024@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 16:31:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFRFe-0005mX-AF
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 16:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab2DDObx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 10:31:53 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:38104 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311Ab2DDObx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 10:31:53 -0400
Received: by wejx9 with SMTP id x9so210128wej.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=oHfk7edeeB38PJR/PO9ZPZUzcmReOLBMW3bdOR4dlIg=;
        b=xM1XFrSzUUFLqyNuKzNn/b4TpI0zM17Z9AAY0ne5etcrZksiJ8KUGzlJILFfOzyV9j
         RPIpOWNFCPHDVBNod9DbCPHXa0Ys/Z63MngzJcRegCjQaLYudzGT0NbMmr0LSYYSSPn3
         L6oN0p6fBwWUpv5cb7Cb0iNAMbwGHJB0D4oxbYyYb2uV541Yormkrb0/EBbCB/SMnuVN
         4hZRUyxQzvVd3Vp/LHejpxmvkLzAiOLvaZ9WYej27R83Smn8RcuqRnwd0AEPZMSTTbNQ
         M1BWNqWJwYiTyQ8++iq783yWVp4yGE4Lai0sXRzXZyqpCtWk2OWRHBFGrQUUkNk2ERzt
         EPrw==
Received: by 10.180.86.132 with SMTP id p4mr5846570wiz.15.1333549911459;
        Wed, 04 Apr 2012 07:31:51 -0700 (PDT)
Received: from [192.168.1.13] (epp57.neoplus.adsl.tpnet.pl. [83.20.57.57])
        by mx.google.com with ESMTPS id b3sm5265601wib.4.2012.04.04.07.31.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 07:31:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120404063939.GA17024@camk.edu.pl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194700>

On Wed, 4 April 2012, Kacper Kornet wrote:
> On Wed, Apr 04, 2012 at 01:12:01AM +0200, Jakub Narebski wrote:
>> On Tue, 3 Apr 2012, Kacper Kornet wrote:

>>> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
>>> index 7aba497..bfeef21 100644
>>> --- a/Documentation/gitweb.conf.txt
>>> +++ b/Documentation/gitweb.conf.txt
>>> @@ -403,6 +403,9 @@ $default_projects_order::
>>>  	i.e. path to repository relative to `$projectroot`), "descr"
>>>  	(project description), "owner", and "age" (by date of most current
>>>  	commit).
>>> +
>>> +$no_list_age::
>>> +	Omit column with date of the most curren commit
> 
>> s/curren/current/
> 
>> Thanks for adding documentation, though I would prefer if you expanded
>> this description (for example including the information that it touches
>> projects list page).
> 
> What about:
> 
> $no_list_age::
> 	Whether to show the column with date of the most current commit on the
> 	projects list page. It can save a bit of I/O.

Perhaps it would be better to say it like this:

  $no_list_age::
  	If true, omit the column with date of the most current commit on the
  	projects list page. [...]

It is true that it can save a bit of I/O: the git_get_last_activity()
examines all branches (some of which are usually loose), and must hit
the object database, unpacking/getting commit objects to get at commit
date.

But the fact that it also saves a fork (a git command call) per repository
reminds me of something which I missed in first round of review, namely
that generating 'age' and 'age_string' fields serve also as a check if
repository really exist.

So either we document this fact, or use some other way to verify that
git repository is valid.

>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index a8b5fad..f42468c 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -133,6 +133,9 @@ our $default_projects_order = "project";
>>>  # (only effective if this variable evaluates to true)
>>>  our $export_ok = "++GITWEB_EXPORT_OK++";
> 
>>> +# don't generate age column
>>> +our $no_list_age = 0;
> 
>> "age" column where?
> 
>> Hmmm... can't we come with a better name than $no_list_age?
> 
> Any of $no_age_column, $omit_age_column, $no_last_commit would be better?

$no_age_column seems better than $no_list_age... but see below. 
 
>>> @@ -5495,7 +5500,8 @@ sub git_project_list_body {
>>>  	                                 'tagfilter'  => $tagfilter)
>>>  		if ($tagfilter || $search_regexp);
>>>  	# fill the rest
>>> -	@projects = fill_project_list_info(\@projects);
>>> +	my @all_fields = $no_list_age ? ('descr', 'descr_long', 'owner', 'ctags', 'category') : ();
>>> +	@projects = fill_project_list_info(\@projects, @all_fields);
> 
>> That looks quite strange on first glance.  I know that empty list means
>> filling all fields, but the casual reader migh wonder about this
>> conditional expression.
> 
>> Perhaps it would be better to write it this way:
> 
>>   -	@projects = fill_project_list_info(\@projects);
>>   +	my @fields = qw(descr descr_long owner ctags category);
>>   +	push @fields, 'age' unless ($no_list_age);
>>   +	@projects = fill_project_list_info(\@projects, @fields);
> 
>> or something like that.
> 
>> Well, at least until we come up with a better way to specify "all fields
>> except those specified".
> 
> Yes, that's better. Especially that I would like also to introduce
> option to prevent printing repository owner everywhere.

Well, because this patch affects gitweb configuration, and because we
need to preserve (as far as possible) the backward compatibility with
existing gitweb configuration files we need to be careful with changes.

Perhaps instead of $no_age_column that can be single configuration
variable like @excluded_project_list_fields instead of one variable
per column.  Somebody might want to omit project description as well
(though then project search must be limited to project names only).
Though this approach will have problem that some of columns simply
have to be present... maybe one variable per column (perhaps hidden
in a hash) is a better solution.

-- 
Jakub Narebski
Poland
