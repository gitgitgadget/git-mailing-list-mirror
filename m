From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: git-svn goes into infinite loop rebuilding rev_map
Date: Sun, 18 May 2008 23:30:55 -0400
Message-ID: <4aca3dc20805182030v4ff6707bo997dfb34110305d4@mail.gmail.com>
References: <4aca3dc20805161015l28d1e4a2u318c1bc23bb5b925@mail.gmail.com>
	 <4E00E139-E354-4336-8290-51CD1B55017A@sb.org>
	 <4aca3dc20805161102y2de0d95cif8a6b643abf722e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, normalperson@yhbt.net
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon May 19 05:32:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxw6i-0002mc-Hv
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 05:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbYESDbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 23:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbYESDa7
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 23:30:59 -0400
Received: from hs-out-0708.google.com ([64.233.178.244]:17982 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYESDa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 23:30:58 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1605079hsl.5
        for <git@vger.kernel.org>; Sun, 18 May 2008 20:30:55 -0700 (PDT)
Received: by 10.90.97.18 with SMTP id u18mr4461727agb.8.1211167855740;
        Sun, 18 May 2008 20:30:55 -0700 (PDT)
Received: by 10.90.49.12 with HTTP; Sun, 18 May 2008 20:30:55 -0700 (PDT)
In-Reply-To: <4aca3dc20805161102y2de0d95cif8a6b643abf722e8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82406>

On Fri, May 16, 2008 at 2:02 PM, Daniel Berlin <dberlin@dberlin.org> wrote:
> On Fri, May 16, 2008 at 1:48 PM, Kevin Ballard <kevin@sb.org> wrote:
>> On May 16, 2008, at 1:15 PM, Daniel Berlin wrote:
>>
>>> Starting last night, for no particularly obvious reason, git-svn fetch
>>> (or git-svn rebase or any command that does naything interesting) on
>>> gcc.gnu.org's repo causes git-svn to do the following:
>>>

I finally got a chance to debug this a bit, and it appears to occur
because rewriteRoot is not taken into account during rebuilding of
metadata.


In this loop in rebuild:
 while (<$log>) {
                if ( m{^commit ($::sha1)$} ) {
                        $c = $1;
                        next;
                }
                next unless s{^\s*(git-svn-id:)}{$1};
                my ($url, $rev, $uuid) = ::extract_metadata($_);
                remove_username($url);

                # ignore merges (from set-tree)
                next if (!defined $rev || !$uuid);
                print "uuid:$uuid, svn_uuid:$svn_uuid, full_url:
$full_url, url: $url!\n";
                my $rwr = $self->rewrite_root;

                # if we merged or otherwise started elsewhere, this is
                # how we break out of it

                if (($uuid ne $svn_uuid) ||
                    ($full_url && $url && ($url ne $full_url))) {
                        next;
                }

                $self->rev_map_set($rev, $c);
                print "r$rev = $c\n";
        }

We end up with
uuid:138bc75d-0d04-0410-961f-82ee72b054a4,
svn_uuid:138bc75d-0d04-0410-961f-82ee72b054a4, full_url:
file:///svn/gcc/trunk, url: svn+ssh://gcc.gnu.org/svn/gcc/trunk

This is because we fetch from the local fs but rewriteRoot it into a
path that works for remote users who want to commit.

However, in that loop that $full_url ne $url so it skips setting the
rev in the rev map, under the assumption it came from elsewhere.

Since it does this for every rev, it never actually puts anything in
the rev map (which means it never creates it).
So it decides to rebuild it again since the file existence fails.
Lather, Rinse, Repeat

The correct fix (i'm not good enough at perl/git-svn to know how to
write this code) is to take rewriteRoot into account.
In addition, it might make sense to assert that when we rebuild the
rev_map, it actually exists when we are done :).

HTH,
Dan
