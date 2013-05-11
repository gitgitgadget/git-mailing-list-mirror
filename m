From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Thoughts about eliminating reachability races
Date: Sat, 11 May 2013 11:47:39 +0200
Message-ID: <518E13BB.8000009@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 11 11:47:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub6P7-0004Lm-6m
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 11:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088Ab3EKJrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 05:47:45 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:50414 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754018Ab3EKJrn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 May 2013 05:47:43 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-bf-518e13be5e8d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.A6.02380.EB31E815; Sat, 11 May 2013 05:47:42 -0400 (EDT)
Received: from [10.43.2.229] ([213.221.117.228])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4B9leQo019214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 11 May 2013 05:47:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqLtPuC/QYNZ1CYuuK91MDowenzfJ
	BTBGcdskJZaUBWem5+nbJXBn7D+xialgi2lF878/LA2M19W7GDk5JARMJFa1LGWEsMUkLtxb
	z9bFyMUhJHCZUeJsxzlWCOcUk8S1nWtYQap4BbQlXl1YyAxiswioSnw6dxQsziagK7Gop5kJ
	xBYVCJNYtX4ZM0S9oMTJmU9YQGwRoJpdz66ygdjCAmYSBx93gNnMAjoS7/oeMEPY8hLb385h
	nsDIOwtJ+ywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGusl5tZopeaUrqJERJO
	fDsY29fLHGIU4GBU4uFVjO4NFGJNLCuuzD3EKMnBpCTK68zaFyjEl5SfUpmRWJwRX1Sak1p8
	iFGCg1lJhPfZA6By3pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEr6MQ
	0FDBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UIzFFwOjDCTFA7TXE6Sdt7ggMRco
	CtF6ilGXY+WVJ68ZhVjy8vNSpcR5NUGKBECKMkrz4FbAkscrRnGgj4V5fUCqeICJB27SK6Al
	TEBLsmK6QZaUJCKkpBoY/SYofQ89kdDNKHdlZtH+C+1Lr7E88pYxvbq/dOGX4F+LDN5qWQif
	sDovyLXo+WOvb1/Y/IVuvnGsfD9NoGXJ0tTXmVsaOvfuqv67Q6ry0HLnIxVz5vJffm45YfVP
	t+Whh4uZuf7N63onFLvU9rOrj+maWdaRU7dXCck9mCyWJTtv6sywwEWmqUosxRmJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223950>

How to get rid of reachability races?

This email is meant more as a basis for discussion (including at the
GitMerge conference that is currently running) than as a fully-baked
proposal.

A lot of reachability-related races have been discussed recently:

* If a reference is renamed while a prune is reading the loose
  references, it could be that prune sees neither the old nor the new
  version of the reference and could prune the objects referred to by
  the reference.

* If a process is building a tree, it could find that some objects are
  already in the DB, in which case it will refer to the existing
  objects.  But these objects might be unreachable, and could be
  pruned before the process gets around to creating a root reference
  that makes them reachable.

* Other races involving packed refs vs. loose refs.

These races are most critical for busy hosting sites like GitHub but
could theoretically impact anybody.

It has been discussed that we should offer, as an alternative to
packed-refs/loose refs in the filesystem, a way to store refs in a
single database store of some kind that offers ACID guarantees.  This
would solve the first and last kind of race in one step.

Other mechanisms are being discussed to address the second race, maybe
involving moving pruned objects into a kind of purgatory for a period
of time before they are finally deleted.

But I have the feeling that these races could also be solved via the
use of the same database.

I am thinking of a scheme in which the database stores two more things
during prunes:

1. The names of objects that are being pruned.  Such objects are
   considered deleted (even though they might not yet have been
   deleted from the object database) and no new references may be made
   to them.

2. The names of objects to which new links have been added.  Prune is
   not allowed to delete this objects or objects to which they refer.

like those used for incremental garbage
collection of memory, in which *during* a garbage collection the VM
keeps tracks of new references that are made to objects that are in
the generation that is currently being garbage collected.  The garbage
collector has to consider these links in its reachability analysis.

Our situation is a little bit more complicated, because it is not easy
to inform a git process that a prune has been started.  At best, the
process can check occasionally whether a prune is running.  On the
other hand, it *is* permissible for Git processes to fail in
exceptional circumstances, as long as it happens rarely and leaves the
object store in a valid state.

So I'm thinking of a scheme in which

1. prune has to list "doomed" objects to the database before deleting
   them.  Such objects are considered deleted by other processes (*if*
   they know that a prune is running).

2. If a process knows that a prune is running, then it records to the
   database any new links that it makes to existing objects.  Prune is
   not allowed to prune such objects.

3. To catch the situation that a process didn't know that a prune is
   running, we keep a prune generation number.  If that number changes
   between the beginning/end of a process, then the process fails
   without recording any new references.


Design goals:

* Correctness

* "Normal processes" don't block on each other or on prune.

* Normal processes don't get significantly slower in the usual case
  (but are allowed to get slower during pruning).


Assumptions:

* There is a store with atomic transactions.

* Most normal processes run more quickly than a prune.  It will be
  rare for an entire prune to run while a normal process is running
  (though even if it does we must behave correctly).

* Normal processes are allowed to fail occasionally as long as they
  leave the DB in a valid state.


In the store, record the following values:

* Git references -- (refname, object_name) pairs

* prune_in_progress (boolean) -- a destructive operation is running

* prune_generation (integer) -- incremented each time objects are
  invalidated

* doomed_objects -- a list of the names of objects that a prune is in
  the process of deleting.  These objects *are considered deleted* and
  may not be referred to.  Only used when prune_in_progress.

* new_links -- a list of the names of objects newly created or newly
  referenced during a prune.  These objects are considered referenced
  and *may not be pruned*.  Only used when prune_in_progress.



A nondestructive operation will usually have two interactions with the
store.  At start::

    def record_new_link(sha1):
        """Record that there is a new link to object sha1."""

        if prune_in_progress:
            if sha1 in doomed_objects:
                die()
            append sha1 to new_links (RAM copy)


    with transaction:
        read prune_generation
        read prune_in_progress
        if prune_in_progress:
            read doomed_objects
        read any needed Git refs

    for each new object or new link to an old object:
        record_new_link(object_name)

    with transaction:
        if prune_generation has changed:
            die()
        if prune_in_progress:
            read current doomed_objects:
            if any of new_links are in doomed_objects:
                die()
            append list of new git references to new_links
        write changes to git references

    # From this moment on, the new_links are considered to be
    # reachable and neither they nor any objects that they refer to
    # may be pruned.



A destructive operation will have at least three interactions with the
store::

    with transaction:
        if prune_in_progress:
            abort
        prune_in_progress = True
        clear doomed_objects list
        clear new_links list
        known_links = list of all object references

    doomed_objects = compute list of objects unreachable from known_links

    while True:
        with transaction:
            write current version of doomed_objects
            read new_links from store
            clear new_links in store

        # From this moment on, objects in doomed_objects are
        # considered deleted.

        if new_links is empty:
            break
        else:
            remove objects reachable from new_links from doomed_objects

    delete doomed objects from filesystem

    with transaction:
        clear list of doomed objects
        increment stored value of prune_generation
        prune_in_progress = False


I hope that's clear; please poke holes in it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
