From: "J.H." <warthog9@kernel.org>
Subject: Re: [PATCH 6/6] GITWEB - Separate defaults from main file
Date: Fri, 11 Dec 2009 07:58:07 -0800
Message-ID: <4B226C0F.2070407@kernel.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>	<1260488743-25855-2-git-send-email-warthog9@kernel.org>	<1260488743-25855-3-git-send-email-warthog9@kernel.org>	<1260488743-25855-4-git-send-email-warthog9@kernel.org>	<1260488743-25855-5-git-send-email-warthog9@kernel.org>	<1260488743-25855-6-git-send-email-warthog9@kernel.org>	<1260488743-25855-7-git-send-email-warthog9@kernel.org> <m3ljh9cy3b.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 16:58:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ7tE-0006cF-9c
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 16:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbZLKP6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 10:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbZLKP6b
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 10:58:31 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:44166 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbZLKP6b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 10:58:31 -0500
Received: from voot-cruiser.eaglescrag.net (76-10-145-13.dsl.ncf.ca [76.10.145.13] (may be forged))
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nBBFw71t027775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Dec 2009 07:58:09 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <m3ljh9cy3b.fsf@localhost.localdomain>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/10149/Thu Dec 10 14:26:20 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Fri, 11 Dec 2009 07:58:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135094>

>> This is also a not-so-subtle start of trying to break up gitweb into
>> separate files for easier maintainability, having everything in a
>> single file is just a mess and makes the whole thing more complicated
>> than it needs to be.  This is a bit of a baby step towards breaking it
>> up for easier maintenance.
> 
> The question is if easier maintenance and development by spliting
> gitweb for developers offsets ease of install for users.

This would just get dropped into the same location that gitweb.cgi 
exists in, there is no real difference in installation, and thus I can't 
see this as an issue for users.

> 
>> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> 
> Signoff mismatch.
> 
>> ---
>>  .gitignore                  |    1 +
>>  Makefile                    |   15 +-
>>  gitweb/Makefile             |    2 +-
>>  gitweb/gitweb.perl          |  515 +++++--------------------------------------
>>  gitweb/gitweb_defaults.perl |  468 +++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 537 insertions(+), 464 deletions(-)
>>  create mode 100644 gitweb/gitweb_defaults.perl
>>
>>
>> diff --git a/.gitignore b/.gitignore
>> index ac02a58..5e48102 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -151,6 +151,7 @@
>>  /git-core-*/?*
>>  /gitk-git/gitk-wish
>>  /gitweb/gitweb.cgi
>> +/gitweb/gitweb_defaults.pl
> 
> Hmmm... gitweb/gitweb_defaults.perl as source file, and
> gitweb/gitweb_defaults.pl as generated file?  Wouldn't it be better to
> go with the convention used elsewhere in gitweb and use
> gitweb/gitweb_defaults.perl.in or gitweb/gitweb_defaults.pl.in as
> source file?

I think you got confused, the committed file is .perl the generated file 
is .pl.

>> +	#$(QUIET_GEN)$(RM) $@ $@+ &&
> 
> What this line is about?

Cruft, thought I had deleted and excluded it, won't be there in next 
version.

> 
>>  	$(QUIET_GEN)$(RM) $@ $@+ && \
>>  	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>>  	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
>> @@ -1539,7 +1541,7 @@ endif
>>  	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
>>  	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
>>  	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
>> -	    $(patsubst %.cgi,%.perl,$@) >$@+ && \
>> +	    $(patsubst %.cgi,%.perl,$(patsubst %.pl, %.perl, $@)) >$@+ && \
> 
> Why the slightly inconsistent style ("%.cgi,%perl" vs "%.pl, %perl")?

Considering that the defaults is more of an include vs. a cgi it 
probably shouldn't share the standard expected executable suffix, thus I 
used .pl.  Could just as easily change it to .pm, or something else but 
I think it would make the most sense to leave things we are expecting 
the webserver to directly execute as .cgi, and includes as a different 
suffix.

> Also wouldn't all replacements be in the new gitweb_defaults file, so
> there would be no need then to do replacements for gitweb.cgi?

Not all replacements are done in one or the other, and since it's 
basically a NOP to perform the full set of replacements on both files 
that seemed the easiest way to ensure they were done in both places.

> Oh, I see there is at least one that stayed in gitweb.perl: $version
> 

<snip>

>> +# Define and than setup our configuration 
>> +#
>> +our(
>> +	$VERSION,
>> +	$path_info,
>> +	$GIT,
>> +	$projectroot,
>> +	$project_maxdepth,
>> +	$home_link,
>> +	$home_link_str,
>> +	$site_name,
>> +	$site_header,
>> +	$home_text,
>> +	$site_footer,
>> +	@stylesheets,
>> +	$stylesheet,
>> +	$logo,
>> +	$favicon,
>> +	$javascript,
>> +	$logo_url,
>> +	$logo_label,
>> +	$projects_list,
>> +	$projects_list_description_width,
>> +	$default_projects_order,
>> +	$export_ok,
>> +	$export_auth_hook,
>> +	$strict_export,
>> +	@git_base_url_list,
>> +	$default_blob_plain_mimetype,
>> +	$default_text_plain_charset,
>> +	$mimetypes_file,
>> +	$missmatch_git,
>> +	$gitlinkurl,
>> +	$maxload,
>> +	$cache_enable,
>> +	$minCacheTime,
>> +	$maxCacheTime,
>> +	$cachedir,
>> +	$backgroundCache,
>> +	$nocachedata,
>> +	$nocachedatabin,
>> +	$fullhashpath,
>> +	$fullhashbinpath,
>> +	$export_auth_hook,
>> +	%known_snapshot_format_aliases,
>> +	%known_snapshot_formats,
>> +	$path_info,
>> +	$fallback_encoding,
>> +	%avatar_size,
>> +	$project_maxdepth,
>> +	$headerRefresh,
>> +	$base_url,
>> +	$projects_list_description_width,
>> +	$default_projects_order,
>> +	$prevent_xss,
>> +	@diff_opts,
>> +	%feature
>>  );
> 
> Why this block is required?  Why not have variables defined (using
> "our") in gitweb_defaults file?

Wanted to make sure things were properly defined, if in an unexpected 
state, should a user have gitweb.cgi in place but not the defaults.

> 
> [cut deletion]  
> 
>> +do 'gitweb_defaults.pl';
>>  
>>  sub gitweb_get_feature {
>>  	my ($name) = @_;
>> diff --git a/gitweb/gitweb_defaults.perl b/gitweb/gitweb_defaults.perl
>> new file mode 100644
>> index 0000000..ede0daf
>> --- /dev/null
>> +++ b/gitweb/gitweb_defaults.perl
>> @@ -0,0 +1,468 @@
>> +# gitweb - simple web interface to track changes in git repositories
>> +#
>> +# (C) 2005-2006, Kay Sievers <kay.sievers@vrfy.org>
>> +# (C) 2005, Christian Gierke
>> +#
>> +# This program is licensed under the GPLv2
>> +
>> +# Base URL for relative URLs in gitweb ($logo, $favicon, ...),
>> +# needed and used only for URLs with nonempty PATH_INFO
>> +$base_url = $my_url;
> 
> Why not "our $base_url = $my_url;"?

same reason as the other 'our' includes above, though why this ended up 
as a separate patch vs. the rest of the file I don't know.

- John 'Warthog9' Hawley
