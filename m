From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete
 for refs we know are packed only
Date: Fri, 23 May 2014 17:23:09 +0200
Message-ID: <537F67DD.5010101@alum.mit.edu>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com> <1400174999-26786-42-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 17:23:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnrJW-00024w-5R
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 17:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbaEWPXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 11:23:13 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:64354 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751637AbaEWPXM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2014 11:23:12 -0400
X-AuditID: 1207440c-f79656d000000c83-96-537f67df202f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 34.FD.03203.FD76F735; Fri, 23 May 2014 11:23:11 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0E41.dip0.t-ipconnect.de [93.219.14.65])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4NFN93A008220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 23 May 2014 11:23:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1400174999-26786-42-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqHs/vT7Y4N4LaYuuK91MFm9vLmG0
	+DehxoHZY+esu+weCzaVenzeJBfAHMVtk5RYUhacmZ6nb5fAndG/5AJTwTaFig3zu1kaGP+L
	dzFyckgImEic79/JDGGLSVy4t56ti5GLQ0jgMqPE9Z3N7BDOOSaJ//92M4FU8QpoS3T1HQHr
	YBFQlXhz7DMLiM0moCuxqKcZqIaDQ1QgSOLPWUWIckGJkzOfgJWICNhJrL+1EKyVWUBDYt2x
	X2AjhQXyJDo/dLGB2EICNRI/t88Eq+EUcJWY8foBO8hICQFxiZ7GIIhWHYl3fQ+gxshLbH87
	h3kCo+AsJNtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQ
	cObZwfhtncwhRgEORiUe3gdMdcFCrIllxZW5hxglOZiURHkTbeuDhfiS8lMqMxKLM+KLSnNS
	iw8xSnAwK4nwFvsB5XhTEiurUovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIaHBwCVw4e
	mc0oxZKXn5eqJME7Mw1oiGBRanpqRVpmTglCKRMHJ8giLimR4tS8lNSixNKSjHhQXMcXAyMb
	JMUDdMPGVJAbigsSc4GiEK2nGHU5Tt051sYkBLZDSpyXDWSHAEhRRmke3ApYUnvFKA70vTBv
	GkgVDzAhwk16BbSECWjJi4W1IEtKEhFSUg2MLH1t9ntnNv+r3/jEk+3qjquskgd3bfnyI/5z
	a/l5i615PN/+Xvqw8XBzcKSJW5vtBY9PYTsDJz386fznaWNeZsW3pfJpqVb2gicF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249991>

On 05/15/2014 07:29 PM, Ronnie Sahlberg wrote:
> Add a new flag REF_ISPACKONLY that we can use in ref_transaction_delete.
> This flag indicates that the ref does not exist as a loose ref andf only as
> a packed ref. If this is the case we then change the commit code so that
> we skip taking out a lock file and we skip calling delete_ref_loose.
> Check for this flag and die(BUG:...) if used with _update or _create.
> 
> At the start of the transaction, before we even start locking any refs,
> we add all such REF_ISPACKONLY refs to delnames so that we have a list of
> all pack only refs that we will be deleting during this transaction.

Let me make a few comments about how I think ref packing fits into the
scheme for pluggable reference back ends.  The comments may or may not
be relevant to this particular commit.

We want to have a reference API that can be implemented by various back
ends.  Obviously we need operations to read a reference, enumerate
existing references, update references within a transaction, and
probably do similar things with symbolic references.

The status quo is that we have a single reference back end consisting of
loose references sitting on top of packed references.

But really, loose references and packed references are two relatively
independent reference back ends [1].  We just happen to use them layered
on top of each other.

This suggests to me that our current structure is best modeled as two
independent reference back ends, with a third implementation of the same
reference API whose job it is to compose the first two.  In pseudocode,

    interface ReferenceBackend:
        read_ref(refname)
        __iter__(...)
        begin_transaction(...)
        update_reference(...)
        ...
        commit_transaction(...)

    class LooseReferenceBackend(ReferenceBackend):
        ...

    class PackedReferenceBackend(ReferenceBackend):
        ...

    class StackedReferenceBackend(ReferenceBackend):
        def __init__(self, backend1, backend2):
            self.backend1 = backend1
            self.backend2 = backend2

        def read_ref(refname):
            try:
                return backend1.read_ref(refname)
            except ReferenceNotFound:
                return backend2.read_ref(refname)

        def __iter__(...):
            i1 = self.backend1.iterate()
            i2 = self.backend2.iterate()
            while i1.has_next() and i2.has_next():
                if i1.peek_next() < i2.peek_next():
                    yield i1.next()
                elif i1.peek_next() == i2.peek_next():
                    yield i1.next()
                    i2.next() # discard
                else
                    yield i2.next()
            while i1.has_next():
                yield i1.next()
            while i2.has_next():
                yield i2.next()

        def pack_refs(...):
            ...

et cetera.

>From this point of view it is clear that packing refs is not an
operation that belongs in the ReferenceBackend API, but rather in the
StackedReferenceBackend interface.  The reason is that it doesn't affect
how references appear to the outside world, but rather just reorganizes
them between the two backends to which StackedReferenceBackend
delegates.  The *implementation* of pack_refs() involves adding
references to backend2 and deleting them from backend1.  But since
adding and deleting references *are* part of the ReferenceBackend API,
StackedReferenceBackend can compose *any arbitrary two* reference
backends (including other StackedReferenceBackends).  Pruning references
that have been packed is also not part of the ReferenceBackend API.
Rather it is a plain old deletion of a reference from backend1 of a
StackedReferenceBackend.

I haven't thought through all of the ramifications of this design, but
I'm pretty sure it's where we want to be headed.

Michael

[1] Forget for the sake of this discussion that we can't store symbolic
references as packed refs.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
