From: John Whitney <jjw@emsoftware.com>
Subject: Re: Bug report
Date: Tue, 09 Oct 2012 12:17:38 -0500
Message-ID: <50745C32.5050505@emsoftware.com>
References: <506D122E.2050404@emsoftware.com> <CABURp0rhHTSqQFiXEb12iKLAAjMW3+Jn-ubMy-9jNWc5068toA@mail.gmail.com> <506DB500.4010803@emsoftware.com> <20121006133146.GD11712@sigill.intra.peff.net> <5070E7BF.8040102@emsoftware.com> <20121007235244.GA5536@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 19:17:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLdRM-0001Ev-IN
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 19:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235Ab2JIRRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 13:17:46 -0400
Received: from mail.emsoftware.com ([76.75.201.49]:64456 "EHLO emsoftware.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754717Ab2JIRRo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 13:17:44 -0400
Received: from Johns-MacBook-Pro.local (ppp-70-253-75-224.dsl.austtx.swbell.net [70.253.75.224])
	by emsoftware.com (Postfix) with ESMTP id 0B3D11AFAC70;
	Tue,  9 Oct 2012 13:21:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <20121007235244.GA5536@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207328>

On 10/7/12 6:52 PM, Jeff King wrote:
>> Yes, but does that really have to be an issue? Is there any technical 
>> or practical reason you can think of that the repository shouldn't 
>> ignore those CRs? 
> It's significantly less efficient. Right now git only has to do the
> conversion when updating the index cache of what's on the filesystem
> (i.e., when it would be doing a sha1 over the file contents _anyway_).
> And then it can compare sha1s internally, because it knows that all of
> the sha1s it has computed are for the canonical in-repo versions of the
> file.
>
> If we assume that the in-repo file might need to have CRs stripped, then
> we need to actually follow up every sha1 mismatch with an actual content
> diff in order to discover if it really is different or not. We could
> cache the "true" sha1 of the canonical stripped version to avoid this,
> but now we are getting much more complex. In most cases it is sufficient
> to just commit the cleaned up contents and then never worry about it
> again.
>
>> You're right, we can't magically avoid all the line ending issues
>> that people will run into. In this case, though, I think git can
>> sidestep a fairly obnoxious problem. My example was simple, but when
>> you've got multiple branches that need to be rebased/merged, it can
>> get pretty hairy. The repository will never be truly "clean" unless
>> you rewrite the whole thing (using filter-branch, for instance).
> Right. Git's current approach is very hairy when you are looking at
> history that crosses a CRLF flag-day boundary. It's definitely a
> weakness of the canonicalization approach. But other approaches also
> have downsides; I don't want to catalogue them all here, but you can
> certainly search the archive for various discussions and flamewars about
> how line endings are handled.
>
>> Maybe my above suggestion is more of a feature request than a bug,
> Fair enough. I think your complaint is real, but I think nobody has been
> clever enough yet to devise a solution that does not have too many other
> downsides. And of course you are free to propose such an approach if you
> have thought of one. :)
>
>> but there is the obvious bug that after changing .gitattributes, git
>> still doesn't notice that files are "modified" until you modify them
>> again in some way (touch works). I only noticed the CRs in our own
>> repository after I tried to rebase a branch and got strange errors.
>> To make git notice all the files, I had to "find . -type f -exec
>> touch {} \;".
> I think the idea has been floated before of unconditionally refreshing
> the index when you update the crlf config via "git config". But of
> course that can only fix a fraction of the cases. You might edit it with
> an editor. Or they may be new lines in .gitattributes. Or a change of
> wildcard lines in .gitattributes.
>
> Really, the issue is that the index contains a cache of what's in the
> files that is considered valid unless the stat information of the file
> changes. But that is obviously not the full story, as the
> canonicalization rules (CRLF handling or smudge/clean filters) can
> change, too, and that is not considered as part of the cache's validity.
> Doing it "right" would mean that anytime the attributes or config files
> changed, we would consider the cache entry dirty and re-read (and
> re-canonicalize) the file.
>
> But that has either:
>
>    1. Bad complexity. It means our cache validity needs to know about
>       exactly which rules were applied to yield the cached sha1. And
>       those rules can be complex, consisting of wildcard matching,
>       cross-referencing custom filters from config, etc.
>
>    2. Bad performance. If you instead just invalidate cached sha1s when
>       the gitattributes or .git/config file changes, you catch way too
>       many cases. E.g., if you checkout a branch that changes
>       .gitattributes, we have to re-read every file in the repository,
>       even though most of them will not be affected.
>
> So I think it's possible to handle this case correctly, but doing it
> right is quite complex. So we have the "just manually poke the files
> when you make such a change". Which is a horrible user experience, but
> works OK in practice (and many people do not run into it at all, because
> on new projects they set the filter attributes very early on, before
> they have an existing history).
>
> IOW, no, it is not pretty, but these are all known issues that nobody
> has felt it worth tackling yet.
>
> -Peff

Thank you very much for your detailed explanations. I suspected that 
efficiency concerns might be preventing a clean solution.

How about this idea... When git stores files, it could include a bit of 
metadata that tells it whether the file is a binary blob or text. 
(Perhaps it already does this?) If a binary blob (in the repository) is 
being compared with a text file (on the filesystem), git could 
re-process the blob and get the "sha1 of the canonical stripped 
version". In all other situations, the original SHA1 should be correct, 
since git already removes CRs from the line endings in files it 
recognizes as text.

I would think that this solution would have no performance penalty for 
"fixed" repositories. (It would only have a small performance hit when 
binary blobs are compared against text files, which is rare even in 
broken repositories.) Git could even throw a warning like: "File xyz.txt 
was originally stored as a binary blob."

What do you think?

    ---John
