From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Allow to control the namespace for replace refs
Date: Thu, 11 Jun 2015 14:13:40 +0900
Message-ID: <20150611051339.GA3637@glandium.org>
References: <1433987235-17385-1-git-send-email-mh@glandium.org>
 <xmqqlhfqhmil.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 07:13:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2uoL-0004fL-K7
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 07:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbbFKFNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 01:13:50 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:53651 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbbFKFNs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 01:13:48 -0400
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1Z2uo8-000444-2n; Thu, 11 Jun 2015 14:13:40 +0900
Content-Disposition: inline
In-Reply-To: <xmqqlhfqhmil.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271376>

On Wed, Jun 10, 2015 at 09:55:30PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > It can be useful to have grafts or replace refs for specific
> > use-cases while keeping the default "view" of the repository
> > pristine (or with a different set of grafts/replace refs).
> >
> > It is possible to use a different graft file with GIT_GRAFT_FILE,
> > but while replace refs are more powerful, they don't have an
> > equivalent override.
> >
> > Add a GIT_REPLACE_NAMESPACE environment variable to control where
> > git is going to look for replace refs.
> >
> > Signed-off-by: Mike Hommey <mh@glandium.org> ---
> >
> > I'm not sure if I need to care about avoiding strlen in log-tree.c,
> > or if I should handle the lack of a / at the end of
> > GIT_REPLACE_NAMESPACE.
> 
> First, let me agree with you that being able to say "I usually use
> refs/replace/ hierarchy as my object replacement database, but for
> this particular invocation of Git (or 'all Git invocations from this
> subprocess' for that matter), I want to use refs/replace-2/ hierarchy
> instead" is a good thing.
> 
> I however doubt that it is a good idea to use the word "namespace"
> anywhere in the name for that mechanism.  Let me explain, and please
> listen with skepticism, as I do not use the ref namespace mechanism
> myself---it is entirely possible that my understanding of how the ref
> namespace mechanism is meant to be used is faulty, and if that is the
> case please correct me.
> 
> The ref namespace mechanism is to be used when you want to serve one
> or more "virtual repositories" via upload-pack/receive-pack server
> side programs from a single repository.  By having two hierarchies,
> each of which is similar to the usual HEAD, refs/heads/, refs/tags/,
> etc., under refs/namespaces/a and refs/namespaces/b, you can allow two
> instances of upload-pack to serve two "virtual repositories".
> 
> What is in refs/namespaces/a/{HEAD,refs/heads/*,refs/tags/*,...} is
> exposed by one instance of upload-pack to its clients as if they are
> the entire world (i.e. HEAD,refs/heads/*,refs/tags/*,...), the other
> one does the same to its clients from refs/namespaces/b/*.  And they
> do share the same object store (thereby allowing you to implement a
> cheap "forks" without having to worry about object borrowing).
> 
> The usual server side housekeeping such as "gc" can and must be
> arranged to happen without limiting them to either namespace, so that
> anything reachable by any ref from either "virtual repository" will be
> retained.

I do agree that this is all confusing, but allow me to point out that
it's already plenty confusing: "namespace" is a term that has been used to
designate a generic kind of namespace *and* refs/namespaces. See for
example:

https://github.com/git/git/blob/master/Documentation/git-describe.txt#L39
https://github.com/git/git/blob/master/Documentation/git-fetch.txt#L113
https://github.com/git/git/blob/master/Documentation/git-filter-branch.txt#L36
(note how this one is specifically about refs/replace/)
there are many more.

> Now, does the "For this invocation, please use refs/replace-2/ as the
> object replacement database" feature have anything common to the ref
> namespace mechanism?  I do not see any commonality, and that is why I
> do not think it is a good idea to use that word.  It will confuse the
> users and the developers alike.
> 
> To me, this mechanism looks very similar to the way you specify a
> non-default notes tree is to be used with the --notes=<ref> parameter,
> core.notesRef configuration and GIT_NOTES_REF environment variable.
> Modeling after that, perhaps using core.replaceRef and GIT_REPLACE_REF
> would be more appropriate, I think.

_REF kind of implies _one_ specific ref. I originally wrote the patch
with _BASE but went with _NAMESPACE instead because it made it somehow
clearer to me that it was about a ref namespace (not refs/namespaces),
not a base directory. I'm not particularly attached to _NAMESPACE, but
I don't find _BASE or _REF particularly compelling. I'm open to better
suggestions.

As for exposing a pref, I'm not entirely sure it makes sense to. In any
case, if we add a pref for it, we should, for consistency, add one for
grafts, except maybe if they are planned to be phased out in favor of
replace refs.

Cheers,

Mike
