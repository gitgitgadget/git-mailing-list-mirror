X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: Computing delta sizes in pack files
Date: Wed, 22 Nov 2006 17:44:11 +0100
Message-ID: <2c6b72b30611220844t4b341284q4bff914b91eac48d@mail.gmail.com>
References: <20061121053942.GA3149@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 16:44:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rKKBVWroaVOeCBQg59jGp1p0DzrFAKZpbIr5rqzQn1c1QUwu4ZDRFvPvdzM3IoexPrGKPqqifDc4QvN4Yz2ANBWwzS7X1Kbal2wz2EGrHv735GwAGnuHW8F6SBIjbSkdUJLlIZnegHfjtAV1bIWuSVzcsNLGrmnYN/O6WyIWS3s=
In-Reply-To: <20061121053942.GA3149@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32090>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmvCr-00028I-Td for gcvg-git@gmane.org; Wed, 22 Nov
 2006 17:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755510AbWKVQoO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 11:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbWKVQoO
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 11:44:14 -0500
Received: from nz-out-0102.google.com ([64.233.162.207]:28923 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1755527AbWKVQoM
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 11:44:12 -0500
Received: by nz-out-0102.google.com with SMTP id s1so158068nze for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 08:44:12 -0800 (PST)
Received: by 10.64.156.1 with SMTP id d1mr8845499qbe.1164213851471; Wed, 22
 Nov 2006 08:44:11 -0800 (PST)
Received: by 10.65.213.20 with HTTP; Wed, 22 Nov 2006 08:44:11 -0800 (PST)
To: "Shawn Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On 11/21/06, Shawn Pearce <spearce@spearce.org> wrote:
> Of course this only looks at a single blob object and does not take
> into account the tree and commit overheads for a given revision,
> but it does give a really good idea of what is going on.

I have some numbers that also includes the other object types. They are
based on running a set of scripts in 5 different repositories. First,
each repository has been both packed and unpacked with respect to the
different object types to show the compression level and disk-space
saving. The main results are compression level for the different object
types and a test to see which pack sizes provide "optimal" packing. I
will not post the numbers here. They are available in
http://jonas.nitro.dk/tmp/stats.pdf for those interested. The following
is my "analysis" of the numbers.

It can be seen that the blob objects generally control the overall
packing properties of the repository, especially when it comes to the
compression level. Generally, there are more tree objects than blob
objects, which can be due to the fact that both the ELinks and Linux
kernel tree are structured into many subdirectories containing few
files.  The Tig repository is exceptional in that it has only few files
and one tree object per revision, which has the effect of reducing the
tree object compression level.  At 83% on average, tree objects compress
very well and in the general case better than blob objects.  As
expected, the randomness of the content of both commit and tag objects
results in a very poor packing performance of only 2%.  In terms of
disk-space usage between packed and unpacked object stores, it is
obvious that the overhead of many small object files is unavoidable.

Next, is the examination of how different pack sizes affect the
compression level. This also includes looking at how the size of the
index file varies.  The columns on per-object sizes are of interest. The
per-object sizes can be compared with the average object size of each
project to get a rough idea of the compression level. In some of the
tables, rows are missing because not all repositories contain enough
objects with respect to the pack sizes being examined.

The data show that for minimal index files, the packs need to contain
more than 2500 objects. The 24 bytes per-object for the optimal case
includes 20-bytes for the object SHA1, and thus cannot be expected to
become lower. For commit objects, the numbers show that there is almost
no difference between small and big packs. The same is assumed to be the
case for tag objects. For tree objects, it becomes very clear that in
repositories with structured source trees, the tree objects compress
much better for big packs, whereas a project, such as Git, does not save
much after pack files reach a size of 250 objects.  Across all
repositories, bigger packs always leads to better compression and fewer
bytes per object, but only for blob objects.

In conclusion, the heuristic of packing based on object type is very
good. Neither commit nor tag objects compress very well when packed.
While both tree and blob objects compress well, tree objects do not
require bigger packs to provide better compression. The pack index files
do not require many objects to become optimal. It should also be noted
from looking at the columns containing numbers about the minimum and
maximum pack sizes that they can vary a lot compared to the average
size.

-- 
