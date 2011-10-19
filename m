From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] Restrict ref-like names immediately below $GIT_DIR
Date: Wed, 19 Oct 2011 17:18:37 +0200
Message-ID: <4E9EEA4D.50207@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu> <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu> <20111011161652.GA15629@sigill.intra.peff.net> <7vr52jfm8i.fsf@alter.siamese.dyndns.org> <7vmxd7flkw.fsf@alter.siamese.dyndns.org> <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org> <20111011230749.GA29785@sigill.intra.peff.net> <7vehyjcckp.fsf@alter.siamese.dyndns.org> <20111012021128.GA32149@sigill.intra.peff.net> <7v39eyddoc.fsf@alter.siamese.dyndns.org> <20111012045004.GA22413@sigill.intra.peff.net> <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org> <4E95D60B.5030904@alum.mit.edu> <7vr52i9j8g.fsf@alter.siamese.dyndns.org> <4E9609E3.1000300@alum.mit.edu> <7v39epft32.fsf@alter.siamese.dyndns.org> <7vty75ec54.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 17:19:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGXvU-0006eH-LV
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 17:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599Ab1JSPTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 11:19:24 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:34507 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab1JSPTX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 11:19:23 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9JFIcwR021054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Oct 2011 17:18:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vty75ec54.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183932>

On 10/19/2011 08:19 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I was trying to summarize this topic for Release Notes.
>>
>>   Possibly incompatible changes
>>   -----------------------------
>>
>>    * Special refs such as "HEAD", "MERGE_HEAD", and "FETCH_HEAD" are now
>>      restricted to names with only uppercase letters and underscore. All
>>      other refs must live under refs/ namespace. Earlier, you could
>>      confuse git by storing an object name in $GIT_DIR/tmp/junk and say
>>      "git show tmp/junk", but this will no longer work.
>>
>> But noticed that "git update-ref tmp/junk HEAD" does create such a ref
>> that won't be recognized, and "git check-ref-format tmp/junk" is happy.
>>
>> I think we would need to restrict check_ref_format() so that these
>> commands (and possibly others, but I think that single function will cover
>> pretty much everything) also reject "tmp/junk" immediately below $GIT_DIR
>> as a bad string. Otherwise we cannot merge these fixups, which would mean
>> we would have to revert the "Clean up refname checks and normalization"
>> series, at least the part that started emitting the "warning", which is a
>> mess I would rather want to avoid.
>>
>> Opinions on how to get us out of this mess?
> 
> Addendum.
> 
> I was digging this further and see fairly large conflicts between the bulk
> of "clean up refname checks and normalization" topic and the logic to
> avoid the additional warning by tightening the dwimmery.
> 
> check_refname_format() has always assumed that it is OK to be called at
> any level of substring, and there are many code like this one (example is
> from remote.c::get_fetch_map()):
> 
>         for (rmp = &ref_map; *rmp; ) {
>                 if ((*rmp)->peer_ref) {
>                         if (check_refname_format((*rmp)->peer_ref->name + 5,
>                                 REFNAME_ALLOW_ONELEVEL)) {
>                                 struct ref *ignore = *rmp;
>                                 error("* Ignoring funny ref '%s' locally",
>                                       (*rmp)->peer_ref->name);
> 
> This code somehow _knows_ that peer_ref->name begins with "refs/" and that
> is the reason it adds 5 to skip that known part. In this particular case,
> I think we can simply drop the +5 and allow-onelevel, but there are other
> instances of the calls to the function that feeds the rest of the refname
> string, skipping leading substring (not necessarily "refs/"), assuming
> that any component string is either valid or invalid no matter where it
> appears in the full refname. I wouldn't be surprised if some callers do
> not even have enough information to tell what the leading substring would
> be in the full refname context (e.g. parsing of "master:master" refspec,
> relying on the later dwimmery to add refs/heads/ in front, could just
> verify that "master" is in good format with allow-onelevel).
> 
> The new restriction bolted on to that logic in jc/check-ref-format-fixup
> series to work around the new warning in 629cd3a (resolve_ref(): emit
> warnings for improperly-formatted references, 2011-09-15) is incompatible
> with the assumption, as we would need to check full refname, and treat the
> first refname component very differently from other components. It has to
> be either "refs" in multi-component refname, or all caps in a one-level
> one, but the callers of check_refname_format() are not designed to feed
> the full refname to begin with.
> 
> I am tempted to revert 629cd3a (resolve_ref(): emit warnings for
> improperly-formatted references, 2011-09-15) that started giving the
> warnings, and drop the jc/check-ref-format-fixup topic [*1*] altogether,
> but that is a short-sighted workaround I would rather want to avoid. It
> essentially declares that the "Clean up refname checks" topic was a
> failure and did not manage to really clean things up.
> 
> A possible alternative might be to leave check_refname_format() and its
> callers as they are, introduce check_full_refname() function that knows
> the new restriction on top of check-ref-format-fixup, and use that in
> lock_ref_sha1(), lock_any_ref_for_update() and is_refname_available()
> [*2*]. That way, we can keep the potentially useful "ill-formed contents
> in the ref" warning and avoid possible confusion caused by random files
> that are directly under $GIT_DIR, which would be far more preferable in
> the longer term.
> 
> Anybody wants to give it a try?

I think that the refs/-or-ALL_CAPS test fits most naturally in
check_refname_format(), controlled by an option flag.

I'm starting by building parts of the solution, namely something like:

* Add an option REFNAME_ALLOW_DWIM which causes check_refname_format()
to accept reference names that *could* be dwimmed into a valid refname.
 Specifically, when this option is *not* specified, then the option must
start with "refs/" or be ALL_CAPS.  When it *is* specified, the behavior
will be much like the current behavior when ALLOW_ONELEVEL is specified
(in fact, the new option might make ALLOW_ONELEVEL obsolete).

* Add a new function parse_refname_prefix(str, len, flags) which tries
to read a refname from the front of str (of length len, not necessarily
NUL-terminated) and returns the length of the part that could be used.
This function will support the same flag argument as
check_refname_format() (in fact the latter would become a trivial
wrapper of the new function).  I expect that this function will be
useful for dwimmery.

Hopefully I'll have patches before the end of the (Berlin) day.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
