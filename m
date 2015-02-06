From: Mark Watts <watts.mark2015@gmail.com>
Subject: Git for collaboration on RDF data
Date: Fri, 6 Feb 2015 13:43:50 -0600
Message-ID: <CALX5DUhUO9fM4SZ6F-Qof6JgDaWCaDmw+8ba-eT7iwD7v_7H0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 20:44:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJoor-0007Xv-V3
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 20:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649AbbBFTnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 14:43:52 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:37957 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622AbbBFTnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 14:43:50 -0500
Received: by mail-qg0-f47.google.com with SMTP id l89so12926239qgf.6
        for <git@vger.kernel.org>; Fri, 06 Feb 2015 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=h5DfTWhifX4Tr2NGYydWr9fXnxIpj5Q//thdp51pJxo=;
        b=LDmTbCKAVlpppt0cfsCBFNmje8qdTQrZaazDiHWVLtPV69f5t4f12dduHpER8j5JfJ
         mYHaJvPGN3VbzqzDmwt4GgSCnzHT9E77wRfQehvmfvxKImTLiZaYDYeMNIqXGYQeAI6+
         H8N+5vXn6X5yOgbm3Gcz7hCUJvAtJR4W1VnhCjQG/kFR1bbryf+HehfBCYCbNubweGXR
         SEseCkbWxqdiYLcoJ4L8dm0gcfI2HyulGKkw8r4LHJqpYf6rYV6yBWa92HbbFZSt5s3V
         qTEi+TGJ//lqI4ROt/e43jk8K8AsgzRdmKxl/qd8Q00xjGK1wNomICa3DRD/kblZaF5f
         5f/g==
X-Received: by 10.229.216.71 with SMTP id hh7mr11823633qcb.0.1423251830147;
 Fri, 06 Feb 2015 11:43:50 -0800 (PST)
Received: by 10.96.150.3 with HTTP; Fri, 6 Feb 2015 11:43:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263420>

I'm interested in a collaboration and change management solution for
data stored in pre-existing RDF data stores set behind SPARQL
endpoints. I would like some input on my idea before I invest too much
time in reading about Git internals. My main question is whether
people more experienced in how Git works internally think that my
problem could be solved by using git itself or if I would be better
served by developing my own toolkit. These first four paragraphs are
to summarize why I'm even thinking of this solution.

I consider that externally managing the versioning of data and not
including that information in the data store would greatly reduce the
usefulness of tracking changes. For example, if multiple versions are
exposed through the SPARQL endpoint, readers would be able to compare
versions through querying with SPARQL rather than by referring back to
a serialized representation of the data in an adjacent repository.
This is most pertinent when the data store is accessed by non-human
agents since I expect that modifying a query or two in such an agent
is easier than adding a feature for reading from an adjacent
repository using a distinct set of protocols. Beyond that are the
dangers of expecting a different set of data than you receive and how
that's difficult to know without cryptographic guarantees of version
information.

I like the idea of using Git since it has gained a wide acceptance and
general understanding, even among the people outside of the software
development profession, who I expect will be generating most of the
data to be tracked. Then, when it comes to collaboration, I can see
that if, for example, I generate some preliminary data in my lab and I
want to share it in RDF, branching like in Git allows me to set off
this preliminary data, but make it available to peers while still
relating it to previously existing data.

My initial requirements for this solution are that commits and merges
shouldn't slow in the time it takes to complete them in proportion to
the size of the database since I want to track stores that can grow to
be millions of statements and several gigabytes in size. Based on my
expectations of the size of data being managed, I also think that
partial sharing of a repository would be useful, but I'm not certain
that this is a requirement.

My idea is to embed at least the object graph of Git in the managed
RDF graph and to make it possible to clone the tracked portion of a
graph by using SPARQL queries. Blobs would correspond to named graphs
in RDF and their hashes would be computed from a serialization of the
graph with "canonicalized" BNodes, and trees would be sets of triples
linking "tree nodes" to "tree entry nodes" to named graph identifiers
paired with blob object ids. For actually manipulating the commit
graph, I expect either to write my own tools or to use FUSE to expose
the RDF graph as a file system that git can manipulate like it does
for normal source code repositories. I like the second option, first,
because it means people can use readily available tools in a way
analogous to how they already use them, and, second, because it allows
for accessing features of Git to manipulate the RDF graph (for better
or worse) in ways that I don't have to explicitly define. My present
concerns for this second option are that I don't know yet everything
that git does on a file system to simulate it and whether I would like
the RDF graph that solution generates. The advantage of the first
option is that I know better what to expect if I go that route, and
the disadvantages are, essentially, the advantages of the second.

Any comment or criticism is welcome.

-- 
Cheers,

Mark W.
