From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: GSOC remote-svn: branch detection
Date: Sat, 4 Aug 2012 12:40:18 +0600
Message-ID: <CA+gfSn__=b1JfL+6LMCqYvJo5mJL_=p7JdRxFspK27OW=0oFLA@mail.gmail.com>
References: <12682331.q6WHVv9EKU@flomedio>
	<20120803181728.GA21745@copier>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 08:40:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxY2D-0004oT-Lv
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 08:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533Ab2HDGkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 02:40:20 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37910 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab2HDGkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 02:40:19 -0400
Received: by obbuo13 with SMTP id uo13so2276457obb.19
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GJVp4tIuoCb1eJ/Zfa4o6EovOEx81d3/cFerl919cT4=;
        b=NXKGUt3e3zUCZLA3oWaT1RnV5pbASULd+3Vj7oWA8+YESKdCDFQO1toZNm3SwtbiIS
         pudByNDR60OXyAZHU8X32dlTu0OZFWDSiHN+zY8veobgSco1CNcvAkohIgXvKjtp7pxC
         DNI2PJ85kswHP+Pw4AgXcE07L/MDMpB2s6D5V+0/A7iQ9E7hVar6C5yLvBz771C+El4x
         Is2OG5O01zKKOAL30/JoZ5JOwc3nH2lSRKi5JUqGCqCMxviBl9Lbq3qepAP35wpfhFsh
         CMWLzG8vLSV47Yhkv3cz+aOani/RTApeIKqNZvPFmoL6+UQExbE8rk4KjYc32l58E0NW
         TU6g==
Received: by 10.50.192.199 with SMTP id hi7mr518699igc.68.1344062418250; Fri,
 03 Aug 2012 23:40:18 -0700 (PDT)
Received: by 10.64.126.42 with HTTP; Fri, 3 Aug 2012 23:40:18 -0700 (PDT)
In-Reply-To: <20120803181728.GA21745@copier>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202872>

Hi,

On Sat, Aug 4, 2012 at 12:17 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Florian Achleitner wrote:
>
>> Two approaches:
>> 1. Import linearly and split later:
>> One idea is to import from svn linearly, i.e. one revision on top of it's
>> predecessor, like now, and detect and split branches afterwards. The svn
>> metadata is stored in git notes, so the required information would be
>> available.
>> + allows recovery, because the linear history is always here.
This is a good one, but I'd put questions another way:
- do we want to query svn server only for newer revisions even if our
settings changed (branch layout ones for example), maybe we don't mind
some queries in settings change case (like git-svn.perl)?
- do we want to be able to filter svn history early (like take
trunk,branches,tags, skip tests_data as it's huge but sometimes there
are svn cp to/from it, or maybe the repo has weird permissions or even
is corrupted)?
- do we just want a completely separate (fast) (local) storage like
svn dump file to use it for imports and settings changes?

I personally still haven't decided on those. My set of pros/cons:
+ should be the simplest thing for simple small repos
+ keeps all the original data details and looks quite robust
- becomes complicated if we don't want or can't import some parts of
the history. While git-svn.perl somehow handles is.
- looks like a thing to store and access svn dump information, do we
really want it to be in a form of git objects (almost sure), how
stable, flexible, independent from svn helper should it be (that's
what Jonathan talks about).

Weird idea: what if we keep everything in one huge git tree like
rXX/{data,props,copy-from,..}/path/path/path/file. It should represent
all the known svn info so far. Ok, I know it's a late stage now and
this thing is completely raw, just posting to have it written out
somewhere :)

>> + it's easier to peek around in the git history than in the svn dump during
>> import to do the branch detection.
>> - requires creation of new commits in the branch detection stage.
>> - this results in double commits and awkward history, linear vs. branched.
>
> I don't think you've captured the real pros and cons here.
>
> + Divides responsibility between a component that fetches and a component
> that splits branches, making for easier debugging, independent refactoring
> of components, reuse in other contexts (e.g., splitting out branches in
> other similar VCSen, etc)
>
> - Divides responsibility between a component that fetches and a component
> that splits branches, which is tricky because it involves designing an
> interface between them and documenting it.  And maybe a different
> interface would be better.
>
> There are also performance and history-clarity ramifications as you've
> mentioned, but they do not seem as important.
>
> Hope that helps,
> Jonathan
>
>> 2. Split during import:
