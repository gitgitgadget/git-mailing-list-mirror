From: Ken Brownfield <krb@irridia.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Fri, 4 Feb 2011 13:17:10 -0800
Message-ID: <010EA68F-6122-47C7-B761-7D786F37B0C6@irridia.com>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com> <201012170254.13005.trast@student.ethz.ch> <9A686258-A504-4CBB-9993-048B45B5EE6A@irridia.com> <20101217030855.GB7003@burratino> <AANLkTi=-0Sj9c5b778jchn+pgw26xCbioQ2K4tNgtm_G@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 22:27:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlTBJ-00075E-GZ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 22:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab1BDV07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 16:26:59 -0500
Received: from endymion.irridia.com ([184.105.192.220]:19439 "EHLO
	endymion.irridia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab1BDV06 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 16:26:58 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Feb 2011 16:26:58 EST
Received: from shrike2.sfo.corp.google.com (unknown [72.14.229.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by endymion.irridia.com (Postfix) with ESMTPSA id 9E1EE145672;
	Fri,  4 Feb 2011 13:17:10 -0800 (PST)
In-Reply-To: <AANLkTi=-0Sj9c5b778jchn+pgw26xCbioQ2K4tNgtm_G@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166058>

Thanks for the feedback on git_fast_filter.  It takes 11.5 hours on our repository instead of 6.5 days, so that's a significant improvement. :-)  I have a couple of observations:

1) You said that your repo would have taken 2-3 months to filter with git-filter-branch, and the time was reduced to ~1hr.  I'm surprised our reduction was not quite as dramatic, although I presume the variability of repo contents are the explanation.

2) The resulting repository pack files are actually much larger.  A garbage collection reduces the size below the original, but only slightly.  I'm concerned that the recreated repository has redundant or inefficiently stored information, but I'm not sure how to verify what objects are taking up what space.

3) git_fast_filter doesn't currently support remote submodules.  When it tries to parse a submodule line, the regex fails and the code aborts:

Expected:
	M 100644 :433236 foo/bar/bletch
Received, something like:
	M 100644 cd821b4c0ea8e9493069ff43712a0b09 foo/bar/bletch

To correct the issue, I modified git_fast_filter to simply skip these.  While we no longer utilize remote submodules, I would prefer not to have them removed.

Any feedback on what the proper behavior would be in the submodule case?  Perhaps this is covered in your internal version?

Thanks,
-- 
Ken

On Dec 16, 2010, at 9:39 PM, Elijah Newren wrote:

> On Thu, Dec 16, 2010 at 8:08 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Ken Brownfield wrote:
>> 
>>> I had considered this approach (and the one mentioned by Jonathan)
>>> but there are no git tools to actually perform the filter I wanted
>>> on the export in this form.
>> 
>> Keep in mind that the two suggestions were subtly different from one
>> another.
>> 
>> For the "filter fast-import stream" technique, apparently there is a
>> tool called reposurgeon[1] to do that.  git_fast_filter[2] has the
>> same purpose, too, if I remember correctly.
> 
> Yes, git_fast_filter was written precisely because git-filter-branch
> took waaaaaay too long.  IIRC, git-filter-branch would have taken
> about 2-3 months for our use case (there's no way we could have shut
> down the repositories for that long), whereas git_fast_filter (serving
> along with fast-export and fast-import) allowed us to drop that to
> about an hour (we couldn't use --index-filter with filter-branch as we
> needed to do a number of operations on the actual file contents as
> well).
> 
> All git_fast_filter really does is parse the fast-export output into
> some basic python data structures, making it easy for you to modify
> those structures as necessary (assuming basic python skills, though if
> you only need to do what one of the examples shows then you could even
> get away without that), and then pipes the results back out in the
> format fast-import expects.  It has a few examples with it; removing
> existing files is one of the simple examples.
> 
> I haven't really bothered keeping the public repository up-to-date
> since there hasn't been any prior external interest in it, but we
> haven't modified it much internally either, and most of those
> modifications are likely for niche stuff that you wouldn't need.
> 
> Elijah
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
