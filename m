From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 4/5] t/t1304: set the mask ACL that is checked in check_perms_and_acl
Date: Mon, 15 Mar 2010 13:17:42 -0500
Message-ID: <D90FzSTc_sIuYUj84CpQ_qxlaiYTWQsa6KDiDVYCRLQ@cipher.nrlssc.navy.mil>
References: <YowxgPZqaOkg2MZzY1CxL1fbmUZ7CMUf5DgqI3S0X83DgqLNI9AGfI83JRNT8LWYHqXBB-PGS1Q@cipher.nrlssc.navy.mil> <YowxgPZqaOkg2MZzY1CxLzeL4DIwxt_o3RKS9xen-cewKbECZA7OIb7mUaY2TbsVR_rHE5GTeU0@cipher.nrlssc.navy.mil> <vpqy6ht5vvs.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 15 19:17:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrErP-0004GA-Rd
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 19:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965613Ab0COSRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 14:17:47 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51928 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965596Ab0COSRq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 14:17:46 -0400
Received: by mail.nrlssc.navy.mil id o2FIHh8B009218; Mon, 15 Mar 2010 13:17:43 -0500
In-Reply-To: <vpqy6ht5vvs.fsf@bauges.imag.fr>
X-OriginalArrivalTime: 15 Mar 2010 18:17:42.0780 (UTC) FILETIME=[CDDC6BC0:01CAC46B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142238>

On 03/15/2010 12:37 PM, Matthieu Moy wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>>  test_expect_success 'Setup test repo' '
>>  	setfacl -m d:u::rwx,d:g::---,d:o:---,d:m:rwx $dirs_to_set &&
>> +	setfacl -m m:rwx               $dirs_to_set &&
> 
> The patch sounds right, but I don't understand the commit message. You
> set m:rwx, and check_perms_and_acl expects mask::r--, so it's not
> exactly what check_perms_and_acl checks.

Ah, yeah, it does sound like I'm saying that check_perms_and_acl is
checking for the particular mask that I'm setting.  I really meant
it to read more like: since check_perms_and_acl is checking the
'mask ACL', it should be set appropriately.

> My understanding is that you set the mask here to enforce the validity
> of the ACL, but then you may want to just squash this into [PATCH 2/5].

I think the ACL is valid according to the rules stated in the Linux man
page, but depending on the previously existing mask ACL on the directories,
the other ACL's that were set may or may not have any effect.  I think on
Linux, the setfacl command updates the effective rights mask when other
ACL entries are modified.  I don't think this happens on Solaris.

If I do this:

  $ cd /var/tmp &&
    mkdir test &&
    setfacl -m d:u::rwx,d:g::---,d:o:---,d:m:rwx test &&
    setfacl -m d:u:guest:rwx test &&
    setfacl -m u:guest:rwx test &&
    getfacl test

On Solaris I get:

  # file: test
  # owner: XXX
  # group: XXX
  user::rwx
  user:guest:rwx                #effective:---
  group::---              #effective:---
  mask:---
  other:---
  default:user::rwx
  default:user:guest:rwx
  default:group::---
  default:mask:rwx
  default:other:---

and on Linux I get:

# file: test
# owner: XXX
# group: XXX
user::rwx
user:guest:rwx
group::---
mask::rwx
other::---
default:user::rwx
default:user:guest:rwx
default:group::---
default:mask::rwx
default:other::---


Notice how the mask entry is different.  On Solaris you get --- and user
'guest' effectively has no permissions, while on Linux it has full rwx.
So for the test we should set the mask explicitly.

-brandon
