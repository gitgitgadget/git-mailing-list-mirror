From: Edward Thomson <ethomson@microsoft.com>
Subject: RE: Rename conflicts in the index
Date: Tue, 26 Mar 2013 18:30:29 +0000
Message-ID: <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com>
 <7va9q72n1u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 19:31:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKYev-00075n-Im
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 19:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603Ab3CZSbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 14:31:19 -0400
Received: from mail-bl2lp0206.outbound.protection.outlook.com ([207.46.163.206]:24092
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750977Ab3CZSbS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Mar 2013 14:31:18 -0400
Received: from BL2FFO11FD007.protection.gbl (10.1.15.200) by
 BY2FFO11HUB011.protection.gbl (10.1.14.82) with Microsoft SMTP Server (TLS)
 id 15.0.651.3; Tue, 26 Mar 2013 18:30:56 +0000
Received: from TK5EX14HUBC107.redmond.corp.microsoft.com (131.107.125.37) by
 BL2FFO11FD007.mail.protection.outlook.com (10.173.161.3) with Microsoft SMTP
 Server (TLS) id 15.0.651.3 via Frontend Transport; Tue, 26 Mar 2013 18:30:55
 +0000
Received: from TK5EX14MBXC253.redmond.corp.microsoft.com ([169.254.3.151]) by
 TK5EX14HUBC107.redmond.corp.microsoft.com ([157.54.80.67]) with mapi id
 14.02.0318.003; Tue, 26 Mar 2013 18:30:30 +0000
Thread-Topic: Rename conflicts in the index
Thread-Index: Ac4f8fcF2rzNm40zS7GBMxbrAtW2UQAI1oifAoxQUOA=
In-Reply-To: <7va9q72n1u.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.54.51.35]
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(51704002)(199002)(189002)(24454001)(20776003)(76482001)(50986001)(44976002)(23726001)(46102001)(47976001)(77982001)(5343635001)(80022001)(50466001)(51856001)(74502001)(33656001)(54316002)(47736001)(55846006)(74662001)(79102001)(69226001)(53806001)(561944001)(56776001)(4396001)(65816001)(56816002)(63696002)(54356001)(46406002)(47446002)(59766001)(31966008)(66066001)(49866001)(16406001)(47776003);DIR:OUT;SFP:;SCL:1;SRVR:BY2FFO11HUB011;H:TK5EX14HUBC107.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 079756C6B9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219176>

Junio C Hamano [mailto:gitster@pobox.com] wrote:
> Edward Thomson <ethomson@microsoft.com> writes:
> 
> > I would propose that we store the data about the file in conflict as
> > it occurred through the renames.  For example, in a rename 1->2
> > conflict where A was renamed to both B and C, you would have a single
> > conflict entry containing the data for A, B and C.  This would allow
> > us to provide more detailed information to the user - and allow them
> > to (say) choose a single name to proceed with.
> >
> > Is this something that has value to core git as well?  Alternately, is
> > there something particularly stupid about this proposal?
> 
> I do not offhand see anything particularly stupid; a new optional index extension
> section CACHE_EXT_RENAME_CONFLICT might be a good addition.
> 
> Is "one side moves A to B while the other side moves it to C" the only case, or is
> it just an example?  Off the top of my head, "one side moves A to x while the
> other side moves B to x/y" would also be something we would want to know.  I
> am sure there are other cases that need to be considered.
> 
> I do not think we can discuss the design at the concrete level until the proposal
> spells out to cover all interesting cases in order for implementations to agree on
> the common semantics.

Sorry about the delay here:  besides getting busy with some other things,
I wanted both a complete writeup and to have taken a pass at a test
implementation this in libgit2 to make sure seemed like a reasonably sensible
approach.

I would propose a new extension, 'CONF', to handle conflict data, differing
from the stage >0 entries in the index in that this extension tracks the
conflicting file across names if the underlying merge engine has support
for renames.

I made an attempt to keep the entry data similar to other entries in the
index.  I would propose that entries in the conflict are as follows:

Flags
  Four octets that describe the conflict.  Data includes:

  0x01  HAS_ANCESTOR
    There is a file in the common ancestor branch that contributes
    to this conflict.  Its data will follow.
  0x02  HAS_OURS
    There is a file in "our" branch that contributes to this conflict.
    Its data will follow.
  0x04  HAS_THEIRS
    There is a file in "their" branch that contributes to this conflict.
    Its data will follow.

  0x08  NAME_CONFLICT_OURS
    This item has a path in "our" branch that overlaps a different
    item in "their" branch.  (Eg, this conflict represents the "our"
    side of a rename/add conflict.)
  0x10  NAME_CONFLICT_THEIRS
    This item has a path in "their" branch that overlaps a different
    item in "our" branch.  (Eg, this conflict represents the "theirs"
    side of a rename/add conflict.)

  0x20  DF_CONFLICT_FILE
    This is the file involved in a directory/file conflict.
  0x40  DF_CONFLICT_CHILD
    This is a child of a directory involved in a directory/file conflict.

  Other bits are reserved.

Conflict Sides
  The data about one side of a conflict will contain:
  mode (ASCII string representation of octal, null-terminated)
  path (null terminated)
  sha1 (raw bytes)

The conflict sides will be written in this order:
  Ancestor (if HAS_ANCESTOR is set)
  Ours (if HAS_OURS is set)
  Theirs (if HAS_THEIRS is set)

I would propose that this not simply track rename conflicts, but all
conflicts.  Having a single canonical location is preferable - if the index
contains a CONF section (and the client supports it), it would use that.
Otherwise, the client would look at stage >0 entries.

I would propose that another extension, 'RSVD', track these conflicts once
they are resolved.  The format would be the same - when a conflict is
resolved from the CONF the entry will be placed as-is in the RSVD.

Examples are not an exhaustive list, but should help elucidate the name
and d/f conflicts:

Normal edit / edit conflict, where A is edited in ours and theirs:

  Conflict one:
    Flags = HAS_ANCESTOR|HAS_OURS|HAS_THEIRS
    Entry 1 = A [Ancestor]
    Entry 2 = B [Ancestor]
    Entry 3 = C [Ancestor]

Rename / add conflict, where A is renamed to B in ours and B is added in
theirs:

  Conflict one:
    Flags = HAS_ANCESTOR|HAS_OURS|NAME_CONFLICT_OURS
    Entry 1 = A [Ancestor]
    Entry 2 = B [Ours]
    Entry 3 = A [Theirs]
  Conflict two:
    Flags = HAS_THEIRS|NAME_CONFLICT_THEIRS
    Entry 1 = File B [Theirs]

D/F conflict, where some file A is deleted in theirs, and a directory
A is created with file child:

  Conflict one:
    Flags = HAS_ANCESTOR|HAS_OURS|HAS_THEIRS|DF_CONFLICT_FILE
    Entry 1 = A [Ancestor]
    Entry 2 = A [Ours]
  Conflict two:
    Flags = HAS_THEIRS|DF_CONFLICT_CHILD
    Entry 1 = A/child [Theirs]

Thanks for your input on this.

-ed
