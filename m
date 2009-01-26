From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow format-patch to create patches for merges
Date: Mon, 26 Jan 2009 10:33:34 -0800
Message-ID: <7v3af57w8x.fsf@gitster.siamese.dyndns.org>
References: <1232978650-7008-1-git-send-email-nathan.panike@gmail.com>
 <alpine.DEB.1.00.0901261604420.25749@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>, git@vger.kernel.org,
	aspotashev@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 19:36:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRWIm-0002jG-Dm
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 19:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbZAZSdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 13:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbZAZSdq
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 13:33:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZAZSdp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 13:33:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EEB451D58F;
	Mon, 26 Jan 2009 13:33:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1E9191D58D; Mon,
 26 Jan 2009 13:33:35 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901261604420.25749@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Mon, 26 Jan 2009 16:36:47 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB3AC0EA-EBD7-11DD-969B-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107242>

--=-=-=

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> - lack an explanation when this makes sense (format-patch is commonly used 
>   for mail-based patch queues, and only -m 1 would make sense there, and 
>   only if you run format-patch with --first-parent),

You do not necessarily want --first-parent.

Suppose you have this topology

         B---D---E
        /   /
   M---A---C

where M is 'master', and E is 'mine'.

The format-patch command ignores merges by default because you can get
diff for A-M, B-A, C-A, E-D and serialize the resulting history without
it, and this is often sufficient.  When D merges with a conflict, or D is
an evil merge, however, you will not be able to reproduce how D looked
like on the receiving end.  Your --first-parent would instead format the
log message for A B D E with patch text of A-M, B-A, D-B and E-D.

But as a recipient of such a patch series, I'd much prefer to see the
patch text and the log message of B and C themselves.  I'd either apply
them on top of A serially, or apply them on top of A to recreate the
forked history the sender had and merge, to arrive at the state the sender
had at D either way, resolving a potential conflict (either when applying
C on top of B, or when merging between B and C), and apply E on top.

Getting a first parent diff that says "I merged random stuff here at D and
here is the difference D-B", is much less useful and throws us back to
dark ages of CVS/SVN merges, especially because C could be a long
multi-patch sequence.

I am not happy about Nathan's output.  I think "-m" output is a wrong
thing to use in that it just lets D-B and D-C patches in the same output
file, without marking that it is something you should not be applying as
part of the series blindly.  The patch is "If you reproduced my B and C
with the patches so far, here is a hint to help you recreate the merged
state D", and care must be taken to make sure both the tool and the user
notice the situation.  "git am", after you have applied B and then C, will
notice that the patches for D does not apply anyway, but the message
should tell the recipient that it is _expected_ not to apply to avoid
confusion.  One possible solution might be to always show --cc patch in
such a case, which (1) won't apply with patch nor git-am, and (2) will be
clear it is not a patch by having more than two @@ signs on each hunk
header.

If you really want to generate a patch for a merge commit (e.g. D in the
above picture), what you may want is "here is a fix-up you need to apply
on top of the result of naturally merging B and C to arrive at D".  It
could be empty if the merge is conflict-free and there is no evil amend.

Here is a food-for-thought sample history for interested parties to
experiment on.


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=t.bun
Content-Transfer-Encoding: base64
Content-Description: a bundle out of a sample repo

IyB2MiBnaXQgYnVuZGxlCjNiZWJhZmMwOWRlMDRkZjRiN2Q1OWY1OTViMTBhZGYyYTMxOTI3MTAg
cmVmcy9oZWFkcy9tYXN0ZXIKMjE4M2MzY2QyZTVlODU4ZWQ2NTYwZTI1NDg4OWEzNWYwZmYzODA3
YiByZWZzL2hlYWRzL21pbmUKMGIyY2YxN2E4MDFlNGMzNzcwYTNlYzdlZWI0M2IwM2U0OTU5Mzdi
MiByZWZzL2hlYWRzL21pbmUyCjNiZWJhZmMwOWRlMDRkZjRiN2Q1OWY1OTViMTBhZGYyYTMxOTI3
MTAgSEVBRAoKUEFDSwAAAAIAAAAYkQ54nJXLQQrCMBBA0X1OMRdQ2kk6yYCI4Ea8xXSSaBdtSkxB
b28XXsDt5/1WUwLKpFFZnVoUzH0mj9lp8DFKduRzFEbHalapaWmQif1OMHQqSEKcfKAegxu8x9ER
JVJmm41s7Vkq3LdlKnCFm8yyFDg9pvZqqV7WMpb3Uct8hh4tMqN1DIcudJ3Z6zy1Xf1xDxh+t5k/
0J5TjeYLt4pDWZYSeJydy01KBDEQhuF9n6J2s1Ly06kkIKKoMAgeolJVPZNFJ0PMgMe3N17Azbd4
eb45VCFGI8Z6GxATJh8FrayYnHDx0YWw2bSZkPJyo6FtAqony0glcCDOKElFiAVpiyYwoQvW5cJ/
PnoqVt0m7JmczcmU9VArZi9YcF2DbFlDWug+r33A573VDm9wpp1ah6dLnd9Tx8utl/7zyH1/Buu8
y/mYAA8mGbMcda/zUP96L186LgplUOMrnPba9AS1zQ7nj9f35Re5r1en+QU3vCGsQYY+9D8ti3hf
eceWVki8j3icW8Y0mUm3pCg1VcHAPCUp2dQwLSk1xTAxJSkl2cDQ3MjcJCnVItkwMcnEwMTUPCXZ
wix1YqzhRD2DiX2GzCaWJhMPWYuZGhop6BpYGBhwcbmWZeYo+KYWpadyAQC+TxobkQ54nJ3LTQ7C
IBBA4T2nmAto6EBhJjHGxI3xFvxaFpQGaaK3t2dw+/K90VMCaZVNTKijDpxyZOVJG8coTXAGvSRi
HfwsNtfTOkBZH3ByQU9kVMpaZYzkLc3ZcrBsZqPJB8rC7WNpHZ77Whrc4eGqWxtcXmW8R+q3rfn2
OYdWrzChQmZUmuEkSUpx1FrGof66Rf3CWEqP4gdfAUMjkg54nJ2MQQ7CIBBF95xiLqCBoUBJjDFx
Y7zFAIN2QWkoTfT2cgZ3/7/893tjBpr9NEllNKF3TqnolBstJpKGZEyRKafMRmzUeO1gg4us0Ro7
2+zMyCw1ZmRnQhgHPiiFMZCgo79rg+exLhXu8KBCa4XLa+l753bbaqifc6zlCgo1eo9aGjjJWUox
aFn6WP1li/KFnWNdk/gB5/BD8f4Ec6seL9w8ohmAtMpkaT1rZEXfnlh4nHvE+IBRt6QoNVXBLNEg
xTw5MSnN0NzU0iLVxNjE3DTR3MI8OcUwzdTMMDE10cjMzMzcfKJuMpORwcRJNkJGBgq6BhYGBlxc
uZUKxZkpqVwAk34VypEOeJydy00KwjAQQOF9TjEXUCZJfzIgIrgRbzHJTLSLNiVNQW9vz+D28b1W
VUGTRT/SkImHxMEPYxTCJCGoZE+pF3GsbjArV10a+KiRc0ISxU5yF0fpKffUR4ss2bG35EaLhvf2
LhWe+zIVuMODZ14KXF5T25rW21pi+ZxTma9gnXdEzgWCEwZEc9R5aof66zbzF/JUt2Z+gU9EuZAL
eJydy00KwjAQQOF9TjEXUJJpazIgRXAj3mLypwGTSJyCx7dncPv4noyUIGb0LgeiZIKJc/RBs1vm
SNmiWWw28ZRYW6d4k2cfcN9a6XCFG1duHc6PIh9J4/Luvn+PodcVDE5IhDgRHLTTWu21FtnVX7cq
rUjhl/oBD1o2OaACeJwzNDAwMzFRSMvMSWVokPJhfnakubbi1yxZ9ebCNs/packAqtIL9rICeJzz
z0t1LcvM4TLiMuYy4XLLLEvlMuMy57Lg8suEygAAnMMI76ACeJwzNDAwMzFRSMvMSWVYv/epq/pd
t72vvXhSHEQ/G2wv3PcMALuQDXa/AXic889LdS3LzOEy4jLmMuEy5TLjMuey4PLLhAoDAHmoB5qg
AnicMzQwMDMxUUjLzEllqI8/YydQPmHWt+rjmdsMou66BmTGAQC0bQyjugF4nPPPS+Uy4jLmMuFy
yyxL5TLjMuey4PLLBIoCAE37Bc+gAnicMzQwMDMxUUjLzEllsI964f/quJDp3DXPjJczy3rf2zfx
NgC0MQ00twF4nPPPS+Uy4jLmMuEy5TLjMuey4PLLBAoBADTkBHqgAnicMzQwMDMxUUjLzEllUA76
qrI0ma/ewXcnf/G5aXNNpdpFAaBSCse1AXicM+Qy4jLmMuEy5TLjMuey4PLLzEvlAgAgEQOJoAJ4
nDM0MDAzMVFIy8xJZej4KezymYcrevqiwli51eqbtG/8TQcAqb0MPLQBeJzzz0vlMuIy5jLhMuUy
4zLnsuCy5AIAJ2YDKaACeJwzNDAwMzFRSMvMSWVgl7TsNOiZrt+lyy9tJXpo3pI1YdEAi1UJ5bIB
eJwz5DLiMuYy4TLlMuMy57LgsuQCABVmAjigAnicMzQwMDMxUUjLzElleDb30exNF685e3drriuP
unHoSU/wRADRWg74MHicAwAAAAABqISEW2nindG/QI1P/Cz0M1A1hUg=
--=-=-=--
