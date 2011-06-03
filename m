From: Drew Northup <drew.northup@maine.edu>
Subject: Re: RFC: C code cleanup
Date: Fri, 03 Jun 2011 12:02:36 -0400
Message-ID: <1307116956.4051.20.camel@drew-northup.unet.maine.edu>
References: <3ECEA53B-C82C-4F3D-9E40-1D81EC17682E@petdance.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Andy Lester <andy@petdance.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 18:02:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSWpl-0005yx-U9
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 18:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab1FCQCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 12:02:44 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:48123 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab1FCQCo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 12:02:44 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p53G2eqA007435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 3 Jun 2011 12:02:40 -0400
In-Reply-To: <3ECEA53B-C82C-4F3D-9E40-1D81EC17682E@petdance.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p53G2eqA007435
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1307721760.84626@7me6mG4ZvLMaYF/BKEAygQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175012>


On Thu, 2011-06-02 at 22:32 -0500, Andy Lester wrote:
> Is the git project interested in patches to code that have no effect on the compiled code, but clean up some of the corners of the code itself?  Or would it be seen as unnecessary code churn?  I'd like to get some feedback before I spend much time on these kinds of cleanups.
> 
> Last night I poked around the code tree and turned on gcc's -Wextra flag.  If these sorts of cleanups are something git likes, I'd also look at running under splint (http://splint.org) to see what it might find as well.  I've been doing the same over on the Perl 5 and Parrot projects for years.  It lets me work on more janitorial issues and do what I can to help oft-neglected bits.
> 
> Following are some changes I think would be useful.  (I realize they are not in the official SubmittingPatches form.  I'm only listing them as examples of what I think would be helpful.)
> 
> Summary:
> * Removed an unused argument from a static function.
> * Modify local pointers to not cast away constness  
> * Remove a test to see if either of two size_t vars are less than zero, which can never happen.
> * Make two mmfile_t * function pointers be const mmfile_t *
> * Declare three local variables to be const.
> 
> I welcome your comments/suggestions/requests.

<snip>

Andy,
While cleanups like this

>     Change pointers in compare_pt() to be const-correct
> 
> diff --git a/builtin/describe.c b/builtin/describe.c
...
>  static int compare_pt(const void *a_, const void *b_)
>  {
> -	struct possible_tag *a = (struct possible_tag *)a_;
> -	struct possible_tag *b = (struct possible_tag *)b_;
> +	const struct possible_tag *a = (const struct possible_tag *)a_;
> +	const struct possible_tag *b = (const struct possible_tag *)b_;

may be welcome, preferably if they are fixing a notable problem, changes
like 

>     Removed unused arg from parse_dates()
> 
> diff --git a/test-date.c b/test-date.c
...
>  
> -static void parse_dates(char **argv, struct timeval *now)
> +static void parse_dates(char **argv)
...
>  	else if (!strcmp(*argv, "parse"))
> -		parse_dates(argv+1, &now);
> +		parse_dates(argv+1);

and this

>     removed unused sha1 argument from cat_one_file()
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
...
> -static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long size)
> +static void pprint_tag(const char *buf, unsigned long size)
...
> -			pprint_tag(sha1, buf, size);
> +			pprint_tag(buf, size);

seem to fail to ask important questions. Why is the code the way that it
is? Should we be making this change? What is the argument for making
this change?

Before proposing changes like this please use git blame to figure out
who should be brought in on the conversation for each patch. It may be
that way for a reason, it may be cruft, and it may be a mistake; but
you'll never know without asking on a case-by-case basis. (Also IIRC,
some patch authors are not on this list, using the output of blame helps
bring them in at the right times.)

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
