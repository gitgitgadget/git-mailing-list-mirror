From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: pack operation is thrashing my server
Date: Sat, 16 Aug 2008 14:47:31 +0200
Message-ID: <20080816124731.GA13444@atjola.homenet>
References: <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141442150.4352@xanadu.home> <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141633080.4352@xanadu.home> <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org> <20080814233958.GA31225@atjola.homenet> <alpine.LFD.1.10.0808141656120.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Transfer-Encoding: 8bit
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 14:52:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KULGq-0007f1-Sn
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 14:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYHPMri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 08:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbYHPMri
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 08:47:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:51998 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751630AbYHPMri (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 08:47:38 -0400
Received: (qmail invoked by alias); 16 Aug 2008 12:47:35 -0000
Received: from i577B8C0F.versanet.de (EHLO atjola.local) [87.123.140.15]
  by mail.gmx.net (mp017) with SMTP; 16 Aug 2008 14:47:35 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19ZpWl/slBZ0ddyior5Ul+1Za+oImp5xtJyApgdpX
	0yqZU0EU0WVliX
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808141656120.3324@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92543>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2008.08.14 17:06:13 -0700, Linus Torvalds wrote:
> The "hash" we use for looking things up is also pretty much a joke, and it 
> has no overflow capability, it just replaces the old entry with a new one.

So I added some stupid tracing to cache_or_unpack entry to see how often
we reread the same stuff. The whole thing just logs the base_offset in
case of a cache miss. I've gc'ed my linux-2.6.git before the run, so
that there's only a single packed_git around (at least I hope so), and I
can ignore that for the tracing.

The whole log for a "git rev-list --objects HEAD" has about 1.2M
entries, while the output of the rev-list command has about 870k lines.
Some postprocessing of the trace shows that the majority of objects is
read only once or twice. A few percent are read three to ten times, and
some are read more than two hundred times.

I'll attach the post-processed thing. The format is:
 x y

Meaning that there were x base_offset values for which we had y cache
misses.

Björn

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cache-misses

 391805 1
 110622 2
  27830 3
  13995 4
   8583 5
   5834 6
   4275 7
   3242 8
   2514 9
   2168 10
   1632 11
   1336 12
   1197 13
    947 14
    788 15
    704 16
    565 17
    514 18
    422 19
    348 20
    304 21
    276 22
    227 23
    233 24
    180 25
    160 26
    145 27
    106 28
    123 29
    109 30
     86 31
     91 32
     72 33
     63 34
     55 35
     73 36
     61 37
     56 38
     48 39
     44 40
     47 41
     36 42
     44 43
     47 44
     32 45
     36 46
     27 47
     19 48
     34 49
     28 50
     22 51
     21 52
     26 53
     18 54
     19 55
     16 56
     22 57
     16 58
     16 59
     11 60
     13 61
     19 62
     17 63
      8 64
     21 65
      8 66
      8 67
     16 68
      9 69
     12 70
     11 71
      8 72
      5 73
      6 74
      9 75
      6 76
      9 77
      7 78
      8 79
      7 80
      8 81
      6 82
      5 83
     13 84
      9 85
      8 86
      4 87
      5 89
      6 90
      3 91
      7 92
      4 93
      5 94
      5 95
      5 96
      4 97
      3 98
      7 99
      2 100
      4 101
      4 102
      7 103
      4 104
      4 105
      5 106
      3 107
      1 108
      4 109
      1 110
      1 111
      1 112
      6 113
      5 114
      2 115
      5 116
      2 117
      2 118
      2 119
      7 120
      1 121
      4 122
      3 123
      3 124
      3 125
      4 126
      1 127
      2 128
      2 129
      2 130
      1 131
      4 132
      1 133
      4 134
      1 135
      2 136
      4 137
      1 139
      3 140
      3 141
      5 142
      5 143
      4 144
      1 148
      2 149
      3 150
      1 151
      2 152
      6 153
      1 154
      2 155
      2 156
      3 157
      2 158
      1 159
      3 160
      2 161
      4 162
      2 163
      5 164
      2 165
      2 166
      2 169
      2 170
      1 171
      1 172
      1 173
      1 176
      2 177
      2 178
      2 179
      1 180
      3 181
      3 182
      1 183
      1 184
      1 186
      1 187
      1 190
      1 192
      1 194
      2 195
      3 196
      1 197
      1 200
      1 201
      1 202
      1 208
      2 214
      2 216
      2 217
      3 224
      1 225
      1 228
      1 230
      2 232
      2 233
      1 234
      2 236
      1 239
      1 241
      1 245
      1 246
      2 249
      2 250
      1 252
      1 259
      1 261
      2 263
      1 266
      2 268
      1 272
      1 282

--W/nzBZO5zC0uMSeA--
