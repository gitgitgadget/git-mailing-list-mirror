From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/4] parse-options: introduce OPT_PATH
Date: Tue, 24 Feb 2015 16:49:25 +0100
Message-ID: <54EC9D85.3010301@drmicha.warpmail.net>
References: <20150223144214.GA31624@peff.net>	<cccf3d14e5582996e5be1467849121a262f9c9f1.1424707497.git.git@drmicha.warpmail.net> <xmqqbnkktoti.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Nguye=5E=7E?=
	 =?ISO-8859-15?Q?n_Th=E1i_Ngo=2Ec_Duy?= <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 16:49:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQHju-0001ZU-PP
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 16:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbbBXPte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 10:49:34 -0500
Received: from plane.gmane.org ([80.91.229.3]:47405 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbbBXPtd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 10:49:33 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YQHjm-0001UT-T2
	for git@vger.kernel.org; Tue, 24 Feb 2015 16:49:30 +0100
Received: from dickson.math.uni-hannover.de ([130.75.46.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 16:49:30 +0100
Received: from git by dickson.math.uni-hannover.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 16:49:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dickson.math.uni-hannover.de
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqbnkktoti.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264332>

Junio C Hamano venit, vidit, dixit 23.02.2015 20:23:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Many options are paths, but not files. Introduce OPT_PATH which does
>> the same path processing as OPT_FILENAME but allows to name the argument.
>> ...
>> diff --git a/parse-options.h b/parse-options.h
>> index 7940bc7..5127a5d 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -149,6 +149,8 @@ struct option {
>>  	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
>>  #define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), \
>>  				       N_("file"), (h) }
>> +#define OPT_PATH(s, l, v, a, h)    { OPTION_FILENAME, (s), (l), (v), \
>> +				       (a), (h) }
> 
> I am somewhat disappointed to see this implementation.
> 
>  - I expected that OPT_FILENAME will be re-implemented in terms of
>    OPT_PATH(), as a thin wrapper.

Right now they are just two macros. Would

#define OPT_FILENAME(s, l, v, h) OPT_PATH((s), (l), (v), N_("file"), (h))

be more what you expect? I don't consider that thinner but don't mind
either way.

>  - As the original complaint was "checkout --to requires a
>    directory, and a file would not work", I expected this to give
>    the programmer finer controls, such as:
> 
>     - The name must refer to an existing entity on the filesystem,
>       or an existing entity on the filesystem must not exist, or
>       anything is fine (tristate).
> 
>     - The name refers to a diretory, or the name refers to a regular
>       file, or the name refers to a symbolic link, or anything goes.
> 
> That is merely "somewhat", as the latter _can_ be coded (e.g. if you
> care that the given path already exists as a directory, stat() it
> and see if it is, or if you want that the given path does not exist
> yet, stat() it to make sure you get ENOENT) after the option is
> parsed by the program that uses the parser.
> 
> But the infrastructure to allow the latter would free you from
> having to say N_("file") or N_("directory"); if a parameter can
> refer to either a file or a directory, the parse-options library
> could give you N_("file or directory") because you are already
> telling what kind(s) of paths are allowed.

So, do you suggest to extend OPTION_FILENAME, and introduce several
macros using it, or a macro taking a bitfield to be filled with
PATH_OPT_FILE, PATH_OPT_DIR, PATH_OPT_EXISTS, PATH_OPT_ABSENT,
PATH_OPT_MASK, PATH_OPT_MODE (require (mode & MASK == MODE))?

Sounds like the big solution to a small problem I had with the word
"file" for a dir...

>>  #define OPT_COLOR_FLAG(s, l, v, h) \
>>  	{ OPTION_CALLBACK, (s), (l), (v), N_("when"), (h), PARSE_OPT_OPTARG, \
>>  		parse_opt_color_flag_cb, (intptr_t)"always" }
