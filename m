From: A Large Angry SCM <gitzilla@gmail.com>
Subject: A look at some alternative PACK file encodings
Date: Wed, 06 Sep 2006 14:47:32 -0700
Message-ID: <44FF41F4.1090906@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 06 23:47:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL5FE-0004xk-Dz
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 23:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWIFVrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 17:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWIFVrh
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 17:47:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:36006 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932159AbWIFVrg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 17:47:36 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1418221nzf
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 14:47:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=sR5NpV9jhRAflB3ItL17m9N+x+dnj9nd95RkmU4H0iFARYAyr4b0wzU8kQhqdV68Us0sy+yfCgKXSmeCHHOLtsdZsOOwQHo3PByWGYmXWBuiuAI9fqPDg2IKiOUlo84KkVFC3XbBd1pevPmu81mI9P0Fgqo9z45/2Enm18PxPoY=
Received: by 10.65.59.20 with SMTP id m20mr7075626qbk;
        Wed, 06 Sep 2006 14:47:35 -0700 (PDT)
Received: from ?10.0.0.6? ( [24.55.157.69])
        by mx.gmail.com with ESMTP id a5sm1704825qbd.2006.09.06.14.47.34;
        Wed, 06 Sep 2006 14:47:35 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26565>

Since I'm currently between jobs and extra time on my hands until I find
a new one, I've been experimenting with some alternative encodings for
PACK file contents.

The tables below show packing statistics for a number of actual pack
files using difference pack file encodings. All of the encodings use
object names to find the base object of a DELTA object.

Encodings:
	Pack_2 - Pack version 2 (Git current), 32 bit
	Pack_3 - Pack version 3 (Git future), 32 bit
	Gitzilla_1 - Experimental >32 bit, described below
	Gitzilla_2 - Experimental >32 bit, described below

Gitzilla_1: Per object header consisting of 2 fields: the Git object
type of the object with a flag indicating if it's delta encoded, big
endian base 128 encoding of the object length. If the object is not
delta encoded, the object header is followed by the deflated object
contents. If the object is delta encoded, the object header is followed
by the 20 byte ID of the base object, and the deflated edit list (see
below). This encoding allows for the possibility of using some of the
bits in the object type field to select one of up to 15 dictionaries.

Gitzilla_2: Per object header consisting of a single field combining the
object type and length; similar to that used in current packs but big
endian encoded. The type could be encoded either as object type with
delta flag (no room for additional object types), or the same as what
version 2 packs (room for additional object types but need to walk the
delta chain to determine type of delta encode objects). If the object is
delta encoded, the object header is followed by the 20 byte ID of the
base object, and the deflated edit list (see below).

Notice that the length encoded in the per object header for delta encode
objects is that of the decoded object, not the length of the inflated
edit list.

The edit lists used in the Gitzilla encodings consist of a sequence of
one or more hunks. Each hunk specifies either a part of the base object
to copy to the current position of the result object, or a length of
(immediate) data to copy to the current position of the result object.

Each hunk type is encode as 2 fields: the first is big endian base 128
encoded length of data to copy with bit 6 of the first byte indicating
where to copy from. The second field is the big endian base 128 encoded
offset in the base object of the copy source, or the (immediate) data to
copy.



Observations:

Most of the savings are from not including the base and result object
lengths in the deflated edit lists.

Other minor savings from joining adjacent edit hunks of the same type,
where possible.

The endian of the base 128 encoding is big because it requires less work
to _decode_ than little.

TREE objects do not delta or deflate well.

Dictionaries will need to be tailored to different object types, and
possibly to other object subsets.

The ability to get the type and length of a delta'd object without
needing to walk the delta chain is a good thing.

The use of _relative_ offsets to specify base objects would save a lot
of space.



The data:

All of the PACK files except bd5109... were rsync'd from the Git project
on kernel.org, at some point. PACK bd5109... is a mash-up of Linus'
kernel and sparse projects, Thomas' kernel history, the stable 2.6.x.y
kernel projects, Git, and gitk; all from kernel.org.

The columns are:
        encoding name
        pack file size
        size of pack file non-object overhead
        sum of packed object sizes
        byte difference in sum of packed object sizes and that of
                version 2 packs
        average byte difference per object
        average byte difference per DELTA'd object



pack-1abe018fa97f8a257a4f3a072000abf99eaa925e.pack

BLOB  :         237
COMMIT:         504
DELTA :        1108
TAG   :           6
TREE  :          64
======   ==========
Total :        1919

Gitzilla_1:     1202917        32     1202885       -6797   -3.5419   -6.1345
Gitzilla_2:     1202011        32     1201979       -7703   -4.0141   -6.9522
Pack_2    :     1209714        32     1209682           0    0.0000    0.0000
Pack_3    :     1209686        32     1209654         -28   -0.0146   -0.0253


pack-3a080dc749b452cc847d19d91981ddfcff629750.pack

BLOB  :        1020
COMMIT:        5300
DELTA :       15013
TAG   :          80
TREE  :         564
======   ==========
Total :       21977

Gitzilla_1:     6748060        32     6748028      -95768   -4.3576   -6.3790
Gitzilla_2:     6737992        32     6737960     -105836   -4.8158   -7.0496
Pack_2    :     6843828        32     6843796           0    0.0000    0.0000
Pack_3    :     6843747        32     6843715         -81   -0.0037   -0.0054


pack-3e6247e4edf3c006a037041eef28bbca8051b006.pack

BLOB  :        1062
COMMIT:        5545
DELTA :       15565
TAG   :          81
TREE  :         703
======   ==========
Total :       22956

Gitzilla_1:     6724940        32     6724908      -97643   -4.2535   -6.2732
Gitzilla_2:     6714303        32     6714271     -108280   -4.7168   -6.9566
Pack_2    :     6822583        32     6822551           0    0.0000    0.0000
Pack_3    :     6822458        32     6822426        -125   -0.0054   -0.0080


pack-6bdf691abdae3590f6a807d15ebe8ed523ef1e12.pack

BLOB  :          33
COMMIT:          36
DELTA :          64
TAG   :           0
TREE  :           4
======   ==========
Total :         137

Gitzilla_1:      136041        32      136009        -273   -1.9927   -4.2656
Gitzilla_2:      135991        32      135959        -323   -2.3577   -5.0469
Pack_2    :      136314        32      136282           0    0.0000    0.0000
Pack_3    :      136314        32      136282           0    0.0000    0.0000


pack-740c99c0be6734adbd130737dec2608dc4682761.pack

BLOB  :         181
COMMIT:         173
DELTA :         383
TAG   :           5
TREE  :          24
======   ==========
Total :         766

Gitzilla_1:      586580        32      586548       -1799   -2.3486   -4.6971
Gitzilla_2:      586264        32      586232       -2115   -2.7611   -5.5222
Pack_2    :      588379        32      588347           0    0.0000    0.0000
Pack_3    :      588370        32      588338          -9   -0.0117   -0.0235


pack-793a9e93286d6c656941977d2e5b49e28566edcd.pack

BLOB  :        1158
COMMIT:        6512
DELTA :       18715
TAG   :          90
TREE  :         820
======   ==========
Total :       27295

Gitzilla_1:     7957552        32     7957520     -120209   -4.4041   -6.4231
Gitzilla_2:     7944784        32     7944752     -132977   -4.8718   -7.1054
Pack_2    :     8077761        32     8077729           0    0.0000    0.0000
Pack_3    :     8077566        32     8077534        -195   -0.0071   -0.0104


pack-92b2a535e63e4a97eba2a13f60c3da922372f03a.pack

BLOB  :        1149
COMMIT:        5969
DELTA :       16930
TAG   :          84
TREE  :         750
======   ==========
Total :       24882

Gitzilla_1:     7243503        32     7243471     -108475   -4.3596   -6.4073
Gitzilla_2:     7231901        32     7231869     -120077   -4.8259   -7.0926
Pack_2    :     7351978        32     7351946           0    0.0000    0.0000
Pack_3    :     7351841        32     7351809        -137   -0.0055   -0.0081


pack-9f1f94e6f50261b5d99c04349bfa3d315cfb4118.pack

BLOB  :        1190
COMMIT:        6244
DELTA :       17881
TAG   :          87
TREE  :         810
======   ==========
Total :       26212

Gitzilla_1:     7920476        32     7920444     -115214   -4.3955   -6.4434
Gitzilla_2:     7908256        32     7908224     -127434   -4.8617   -7.1268
Pack_2    :     8035690        32     8035658           0    0.0000    0.0000
Pack_3    :     8035529        32     8035497        -161   -0.0061   -0.0090


pack-a875e0c11c739866b000dc9b34d1b0daead84a00.pack

BLOB  :          20
COMMIT:           9
DELTA :          15
TAG   :           1
TREE  :           3
======   ==========
Total :          48

Gitzilla_1:       71748        32       71716         -54   -1.1250   -3.6000
Gitzilla_2:       71728        32       71696         -74   -1.5417   -4.9333
Pack_2    :       71802        32       71770           0    0.0000    0.0000
Pack_3    :       71802        32       71770           0    0.0000    0.0000


pack-abbe9cdea12803663015a7e23b7ae61c64e56499.pack

BLOB  :         259
COMMIT:         342
DELTA :         705
TAG   :          13
TREE  :          47
======   ==========
Total :        1366

Gitzilla_1:     1086337        32     1086305       -3878   -2.8389   -5.5007
Gitzilla_2:     1085773        32     1085741       -4442   -3.2518   -6.3007
Pack_2    :     1090215        32     1090183           0    0.0000    0.0000
Pack_3    :     1090215        32     1090183           0    0.0000    0.0000


pack-bd5109ab74dd67d5b0a42f26688a4fa0a579e9fa.pack

BLOB  :       29212
COMMIT:      103241
DELTA :      702986
TAG   :         182
TREE  :       37102
======   ==========
Total :      872723

Gitzilla_1:   282786611        32   282786579    -3647429   -4.1794   -5.1885
Gitzilla_2:   282143551        32   282143519    -4290489   -4.9162   -6.1032
Pack_2    :   286434040        32   286434008           0    0.0000    0.0000
Pack_3    :   286404302        32   286404270      -29738   -0.0341   -0.0423


pack-d18e6cccf9e472ba05e108254c827cc7ac0fe2a9.pack

BLOB  :        1564
COMMIT:        3118
DELTA :        8288
TAG   :          51
TREE  :         365
======   ==========
Total :       13386

Gitzilla_1:     5638236        32     5638204      -44212   -3.3029   -5.3345
Gitzilla_2:     5632126        32     5632094      -50322   -3.7593   -6.0717
Pack_2    :     5682448        32     5682416           0    0.0000    0.0000
Pack_3    :     5682423        32     5682391         -25   -0.0019   -0.0030


pack-d25faec39a55935d787ae66e4f4a69d3add16417.pack

BLOB  :        1180
COMMIT:        6090
DELTA :       17458
TAG   :          85
TREE  :         761
======   ==========
Total :       25574

Gitzilla_1:     7646842        32     7646810     -112816   -4.4114   -6.4621
Gitzilla_2:     7634964        32     7634932     -124694   -4.8758   -7.1425
Pack_2    :     7759658        32     7759626           0    0.0000    0.0000
Pack_3    :     7759521        32     7759489        -137   -0.0054   -0.0078


pack-d453bb50fef8757a0d7f9fcc88429e9ce6f74077.pack

BLOB  :          28
COMMIT:          35
DELTA :          46
TAG   :           2
TREE  :           6
======   ==========
Total :         117

Gitzilla_1:      177544        32      177512        -266   -2.2735   -5.7826
Gitzilla_2:      177478        32      177446        -332   -2.8376   -7.2174
Pack_2    :      177810        32      177778           0    0.0000    0.0000
Pack_3    :      177806        32      177774          -4   -0.0342   -0.0870


pack-d83305b8608cb685ecd025fb141bf9d1588ae9c5.pack

BLOB  :          91
COMMIT:         108
DELTA :         202
TAG   :           2
TREE  :          26
======   ==========
Total :         429

Gitzilla_1:      473503        32      473471       -1112   -2.5921   -5.5050
Gitzilla_2:      473269        32      473237       -1346   -3.1375   -6.6634
Pack_2    :      474615        32      474583           0    0.0000    0.0000
Pack_3    :      474603        32      474571         -12   -0.0280   -0.0594


pack-ee22eefd6bad2b54358d52ad6221ecabdc79d6f5.pack

BLOB  :         175
COMMIT:         210
DELTA :         541
TAG   :           2
TREE  :          38
======   ==========
Total :         966

Gitzilla_1:      662650        32      662618       -3230   -3.3437   -5.9704
Gitzilla_2:      662150        32      662118       -3730   -3.8613   -6.8946
Pack_2    :      665880        32      665848           0    0.0000    0.0000
Pack_3    :      665865        32      665833         -15   -0.0155   -0.0277


pack-f0c530478b9dd6e96a69482066ec66eb5f6edbbf.pack

BLOB  :        1154
COMMIT:        5797
DELTA :       16300
TAG   :          83
TREE  :         739
======   ==========
Total :       24073

Gitzilla_1:     7212953        32     7212921     -102252   -4.2476   -6.2731
Gitzilla_2:     7201730        32     7201698     -113475   -4.7138   -6.9617
Pack_2    :     7315205        32     7315173           0    0.0000    0.0000
Pack_3    :     7315059        32     7315027        -146   -0.0061   -0.0090
