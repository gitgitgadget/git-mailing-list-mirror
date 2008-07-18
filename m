From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Fri, 18 Jul 2008 15:40:01 +0200
Message-ID: <48809D31.5030008@gmail.com>
References: <4876B223.4070707@gmail.com> <200807162021.56380.jnareb@gmail.com> <487E5AD3.60202@gmail.com> <200807180149.18565.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 15:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJqCu-0001Qb-Mh
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 15:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325AbYGRNkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 09:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757190AbYGRNkM
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 09:40:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:51650 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896AbYGRNkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 09:40:09 -0400
Received: by fk-out-0910.google.com with SMTP id 18so237351fkq.5
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 06:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=94sTnrqEuywm8aWFXE75i4uQTKtBlBoyS71gFkxtCwA=;
        b=IFApKMViDWbsOIRZp58qONvqwY6p8iflQyoIZLqhzthjdCeFVUZR6SspANTf3QEDrZ
         oWE2OMM6E4LzFR0OaOM/LOMyNDFSdK2c7quAZT4pKZQm4l1B4u/n8cgm8kJ5rD9KgE00
         G++iYAJ+m2rEEr+b38B+h+FCB73yDDupRsDsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=MPPg1D8hy4oYPrqr9IN69rMwqAZ2XeT4uNSGLUtGWt66h9evIbFDe6zY/6EByOvIEF
         OZ0cSrIi35ZkNCX1zUoVDHw//oGXw3UkaGHDleFWM2d7TkbcJ8G80XzHQprGZ4yVS6cN
         Z7k+N979hs6F40SFOfkZT2FBQfmUpU159C4Aw=
Received: by 10.180.234.2 with SMTP id g2mr97556bkh.54.1216388405619;
        Fri, 18 Jul 2008 06:40:05 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.253.216])
        by mx.google.com with ESMTPS id 37sm4832736hua.58.2008.07.18.06.40.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 06:40:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200807180149.18565.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89040>

Jakub Narebski wrote:
> [$commit->author:] We would probably want _in the future_ to  return some
> object wrapper, which stringifies to value of author and committer headers

Yup, good idea.  They'll even stay strings, they'll just be blessed.

>>>> +=item $commit->message
> 
> I'd rather then have _git_ convert it to UTF=8 for us (using 
> --encoding=<encoding> option to git-log/git-rev-list)

Yeah, I guess the API should actually decode it.  You wouldn't want to
have the message in UTF-8 but in Unicode (I suggest you read man
perlunitut if you haven't done so).  We cannot have git do the decoding,
since (apart from the fact that it doesn't smell right) it isn't
guaranteed to emit valid UTF-8 (thanks Junio for the pointer):

Lea Wiemann: Does anyone know off the top of their heads how git handles
    character decoding errors in commands like git log? [...]
Junio 'gitster' Hamano: silently punt and show the original unmolested.
Junio 'gitster' Hamano: cf. pretty.c:pretty_print_commit()

So we're not guaranteed to be able to, in turn, decode git's output into
actual characters since it might just be byte soup.

Hence, how about this fallback strategy:

1. Decode according to the encoding header.
2. Decode as UTF-8 (passing through byte soup is often equivalent to
decoding UTF-8 since many terminals use UTF-8, and trying UTF-8 is
reasonably safe).
3. Decode as Latin1.

(Not that the fallbacks will matter a lot in practice, I think.)

> It is (much) better than forking git-cat-file for each commit shown
> on the list; nevertheless I think that it would be better to use git-log
> to generate list (or Git::Revlist) of Git::Commit objects.  It is one
> fork less, but what more important you don't have to access repository
> twice for the very same objects.

You're confused; it's not one fork less, it's a write to a pipe less.
(Pleeeease look at the code before you write something.  It's there, in
this very thread.)  And I don't believe the "access the repository
twice" thing is anywhere near an actual issue.  To summarize, you're
asking me to (a) write code and (presumably) (b) add something to the
interface of a public API, based on some (most probably faulty)
assumptions about performance?  You should really read
<http://c2.com/cgi/wiki?PrematureOptimization>.

> if I understand correctly for log-like views you 
> propose to first run simple git-rev-list [...], then feed list of
> revisions (perhaps via cache, i.e. excluding objects which are in
> cache) to 'git cat-file --batch' open two-directional pipeline.

Yup, it's an option, though currently it's a single cached call to git
log (or git rev-list).

> What I propose instead is to provide alternate method to fully 
> instantiate Git::Commit object (in addition to ->_load), which would 
> fill fields by parsing git-log / git-rev-list --headers output

Yes, but this would need a method in the API, it's not an optimization
that falls out for free.  Cluttering an API for some obscure (= very
doubtful) optimization?  Bad Idea.(tm)

> "git cat-file --batch" should have commits to be
> accessed in filesystem cache, which means in memory; but it is possible
> that they wouldn't be in cache because of I/O pressure

No.  Page cache turnover time is at least around 10 seconds (and that's
under fairly artificial conditions), definitely not in the millisecond
range.

> I think that _not using_ Git::Cmd (or somesuch) API results in botched,
> horrible API
>   our $git_version = $repo_root->repo(directory => 'dummy')->version;
> (Unless it is not needed any longer, or not used any longer; if it is
> so, then perhaps implementing Git::Cmd as generic wrapper around git
> commands, hiding for example ActivePerl hack, could be left for later).

It isn't used any longer -- I really suggest you read the whole thread
before replying. ;-)

>> As I wrote in my reply to Petr [...]
> 
> Just a question: was this reply only to him, or to all?

To all, otherwise I wouldn't have Cc'ed the list.

>> I wouldn't -- see my blurb about error handling at the top of my reply
>> to Petr (<487BD0F3.2060508@gmail.com>).  You're not supposed to pass
>> anything that you didn't get from get_sha1 into Git::Commit or
>> Git::Tag constructors, or your error handling is invariably broken.
> 
> I can understand this simpler, although less than optimal, and geared
> mainly towards gitweb needs.

FTR, yes it is simpler, but no, it is not really geared toward gitweb
needs, and it's definitely not "less than optimal" in the sense of being
worse than the exception-based error handling Git.pm does.  Trust on me
on this one. ;-)

> Errr... "yes" to first question means that 'reuse' option makes sense
> _only_ for get_bidi_pipe? If so, why it is present in other commands?

Yes, and no, it isn't present in other commands.  (Hey, could you please
check the code before posting?  Really.)

>>> Why name_rev, and no describe?
>> Feel free to add it. ;-)  (It might take some work to come up with a
>> decent interface for that method.)
> 
> Why do you _need_ name_rev, if you are not to include git-describe
> equivalent.

I needed it for gitweb.  As I said, I'm not trying to create a complete
API.  A describe_rev (or so) method can be added later, if and when it's
needed.  (As I said, I don't think writing APIs without at least one use
case is a good idea anyway.)

>>> Should (for completeness) Git::Tag provide $tag->validate() method?
> 
> I meant here equivalent of "git tag -v <tag>"

I guess it could be added.  As with describe_rev, I won't add it myself,
in particular not as part of this patch series.

-- Lea
